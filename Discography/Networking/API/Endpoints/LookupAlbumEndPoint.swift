//
//  LookupAlbumEndPoint.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

extension ItunesClient {
    
    struct LookupAlbumsEndPoint: EndPointType {
        typealias response = ItunesAlbumResponse
        
        let id: Int
        
        var urlParameters: [URLQueryItem] {
            return [
                URLQueryItem(name: "id", value: String(id)),
                URLQueryItem(name: "entity", value: "album")
            ]
        }
        
        var path: String {
            return "/lookup"
        }
    }
    
    @discardableResult func searchAlbums(for artistId: Int, completion: @escaping ([Album]?, Error?)-> Void) -> URLSessionDataTask? {
        let searchRequest = LookupAlbumsEndPoint(id: artistId)
        return request(endpoint: searchRequest) { (response, error) in
            completion(response?.results, error)
        }
    }
    
}
