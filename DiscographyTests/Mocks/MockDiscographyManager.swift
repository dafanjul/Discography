//
//  MockDiscographyManager.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation
@testable import Discography

class MockDiscographyManager: DiscographyManagerType {
    
    var cancelAllRequestsCalled = false
    var cancelRequestCalled = false
    var cancelRequestArtistReceived: Int?
    var requestDiscographyArtistId: Int?
    var requestDiscographyCompletionReceived: (([Album]?, Error?) -> Void)?
    var requestDiscographyCalled = false
    
    func requestDiscography(for artistId: Int, completion: @escaping ([Album]?, Error?) -> Void) {
        requestDiscographyArtistId = artistId
        requestDiscographyCompletionReceived = completion
        requestDiscographyCalled = true
    }
    
    func cancelAllRequests() {
        cancelAllRequestsCalled = true
    }
    
    func cancelRequest(for artistId: Int) {
        cancelRequestCalled = true
        cancelRequestArtistReceived = artistId
    }
    
    
}
