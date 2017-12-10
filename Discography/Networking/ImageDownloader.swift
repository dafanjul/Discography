//
//  ImageDownloader.swift
//  Discography
//
//  Created by Dario Fanjul on 07/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

typealias ImageCacheType = NSCache<NSString, NSData>

final class ImageDownloader: ImageDownloaderType {
    
    //MARK: - Private
    private var session: URLSession
    private var cache: ImageCacheType
    private var configurator: Configurator
    
    //MARK: - Lifecycle
    init(urlSession: URLSession = URLSession.shared, cache: ImageCacheType, configurator: Configurator = Configurator()) {
        self.session = urlSession
        self.cache = cache
        self.configurator = configurator
    }
    
    //MARK: - Actions
    func downloadImageData(with url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask? {
        if let cachedData = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedData as Data, nil)
            return nil
        }
        configurator.networkActivity.startedRequest()
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            self?.configurator.networkActivity.stoppedRequest()
            guard let data = data,
                error == nil else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    
                    return
            }
            self?.cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }
        task.resume()
        
        return task
    }
    
}

extension ImageDownloader {
    
    struct Configurator {
        let networkActivity: NetworkActivityType.Type = NetworkActivity.self
    }
    
}
