//
//  MockAPIClient.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation
@testable import Discography

class MockAPIClient: APIClientType {
    
    var searchArtistCalled = false
    var searchAlbumsCalled = false
    var searchArtistText: String?
    var searchAlbumArtistId: Int?
    var completionSearchArtistReceived: (([Artist]?, Error?) -> Void)?
    var completionSearchAlbumReceived: (([Album]?, Error?) -> Void)?
    
    func searchArtist(with text: String, completion: @escaping ([Artist]?, Error?) -> Void) -> URLSessionDataTask? {
        completionSearchArtistReceived = completion
        searchArtistCalled = true
        searchArtistText = text
        
        return MockURLSessionDataTask()
    }
    
    func searchAlbums(for artistId: Int, completion: @escaping ([Album]?, Error?) -> Void) -> URLSessionDataTask? {
        completionSearchAlbumReceived = completion
        searchAlbumsCalled = false
        searchAlbumArtistId = artistId
        
        return MockURLSessionDataTask()
    }
    
}
