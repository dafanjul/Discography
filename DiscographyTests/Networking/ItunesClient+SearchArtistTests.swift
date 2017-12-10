//
//  ItunesClient+SearchArtistTests.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import XCTest
@testable import Discography

class ItunesClient_SearchArtistTests: XCTestCase {
    
    var sut: ItunesClient!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = ItunesClient(urlSession: mockSession)
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testSuccessResponse() {
        let completionCalled = expectation(description: "completion called")
        
        sut.searchArtist(with: "test") { (result, error) in
            XCTAssertEqual(result?.count, 12)
            completionCalled.fulfill()
        }
        
        let response = generateSuccessResponseFrom(filename: "SearchArtistsResponse")
        mockSession.completionReceived?(response.jsonData, response.response, nil)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
