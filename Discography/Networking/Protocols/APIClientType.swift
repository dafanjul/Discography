//
//  APIClientType.swift
//  Discography
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

protocol APIClientType {
    
    @discardableResult func searchArtist(with text: String, completion: @escaping ([Artist]?, Error?)-> Void) -> URLSessionDataTask?
    @discardableResult func searchAlbums(for artistId: Int, completion: @escaping ([Album]?, Error?)-> Void) -> URLSessionDataTask?
    
}
