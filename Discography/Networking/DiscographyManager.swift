//
//  DiscographyManager.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

final class DiscographyManager {
    
    //MARK: - Private
    private let client: APIClientType
    private var requests = Set<DiscographyRequest>()
    private var results = Set<DiscographyResult>()
    
    //MARK: - Lifecycle
    init(client: APIClientType) {
        self.client = client
    }
    
    //MARK: - Actions
    func requestDiscography(for artistId: Int, completion: @escaping ([Album]?, Error?) -> Void) {
        if let cachedResult = results.first(where: { $0.artistId == artistId }) {
            completion(cachedResult.albums, nil)
            
            return
        }

        let task = client.searchAlbums(for: artistId) { [weak self] (albums, error) in
            if let element = self?.requests.first(where: {$0.artistId == artistId}) {
                self?.requests.remove(element)
            }
            guard error == nil,
                let albums = albums else {
                completion(nil, error)
                    
                return
            }
            let result = DiscographyResult(artistId: artistId, albums: albums)
            self?.results.insert(result)
            completion(albums, nil)
        }
        if let operationRequest = task {
            let request = DiscographyRequest(artistId: artistId, request: operationRequest)
            requests.insert(request)
        }
    }
    
    func cancelRequest(for artistId: Int) {
        if let request = requests.first(where: { $0.artistId == artistId }), request.request.state == URLSessionDataTask.State.running {
            request.request.cancel()
        }
    }
    
    func cancelAllRequests() {
        requests.forEach { (request) in
            print("Cancelled all request: \(requests.count)")
            request.request.cancel()
        }
    }
    
}

extension DiscographyManager {
    
    fileprivate struct DiscographyRequest: Hashable {
        
        let artistId: Int
        let request: URLSessionDataTask
        
        var hashValue: Int {
            return artistId
        }
        
        static func ==(lhs: DiscographyManager.DiscographyRequest, rhs: DiscographyManager.DiscographyRequest) -> Bool {
            return lhs.artistId == rhs.artistId
        }
        
    }
    
    fileprivate struct DiscographyResult: Hashable {
        
        let artistId: Int
        let albums: [Album]
        
        var hashValue: Int {
            return artistId
        }
        
        static func ==(lhs: DiscographyManager.DiscographyResult, rhs: DiscographyManager.DiscographyResult) -> Bool {
            return lhs.artistId == rhs.artistId
        }

    }
    
}

extension DiscographyManager: DiscographyManagerType {}
