//
//  SearchArtistEndPoint.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

extension ItunesClient: APIClientType {}

extension ItunesClient {
    
    struct SearchArtistEndPoint: EndPointType {
        typealias response = ItunesResponse<[Artist]>
        
        let searchText: String
        
        var urlParameters: [URLQueryItem] {
            return [
                URLQueryItem(name: "term", value: searchText),
                URLQueryItem(name: "entity", value: "musicArtist"),
                URLQueryItem(name: "attribute", value: "allArtistTerm")
            ]
        }
        
        var path: String {
            return "/search"
        }
    }
    
    
    @discardableResult func searchArtist(with text: String, completion: @escaping ([Artist]?, Error?)-> Void) -> URLSessionDataTask? {
        let searchRequest = SearchArtistEndPoint(searchText: text)
        return request(endpoint: searchRequest) { (response, error) in
            completion(response?.results, error)
        }
    }
    
}
