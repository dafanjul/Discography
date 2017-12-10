//
//  EndpointType.swift
//  Discography
//
//  Created by Dario Fanjul on 05/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

protocol EndPointType {
    associatedtype response: Decodable
    
    var environment: Environment { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var urlParameters: [URLQueryItem] { get }
    func processResponse(data: Data) -> (response?, Error?)
}

extension EndPointType {
    
    var environment: Environment {
        return DevelopmentEnvironment()
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var urlParameters: [URLQueryItem] {
        return []
    }
    
    func processResponse(data: Data) -> (response?, Error?) {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(response.self, from: data) else {
            
            return (nil, NetworkError.invalidData)
        }
        
        return (decodedData, nil)
    }
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = environment.scheme
        urlComponents.host = environment.host
        urlComponents.path = path
        urlComponents.queryItems = urlParameters

        return urlComponents
    }
}
