//
//  SearchViewModelTests.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import XCTest
@testable import Discography

class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    var mockClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient()
        sut = SearchViewModel(apiClient: mockClient)
    }
    
    override func tearDown() {
        sut = nil
        mockClient = nil
        super.tearDown()
    }
    
    func testSearchArtist_CallsSearchArtist() {
        let expectedSearch = "search artist"
        
        sut.searchArtist(text: expectedSearch)
        
        XCTAssertTrue(mockClient.searchArtistCalled)
        XCTAssertEqual(mockClient.searchArtistText, expectedSearch)
    }
    
    func testSearchArtist_SuccessShouldReturnResult() {
        let expectedResponse = [Artist(artistName: "Test Artist",
                                       artistId: 1234,
                                       primaryGenreName: "Genre")]
        let eventCalled = expectation(description: "event")
        
        sut.searchArtist(text: "Test")
        sut.didReceiveData = { result in
            XCTAssertEqual(result.numberOfElements, expectedResponse.count)
            eventCalled.fulfill()
        }
        mockClient.completionSearchArtistReceived?(expectedResponse, nil)
     
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testSearchArtist_ErrorShouldCallErrorEvent() {
        let eventCalled = expectation(description: "event")
        
        sut.searchArtist(text: "Test")
        sut.didError = { (title, error) in
            XCTAssertNotNil(title)
            XCTAssertNotNil(error)
            eventCalled.fulfill()
        }
        mockClient.completionSearchArtistReceived?(nil, NetworkError.invalidData)
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

