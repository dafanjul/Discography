//
//  SearchArtistEndPoint.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import XCTest
@testable import Discography

class SearchArtistEndPointTests: XCTestCase {
    
    func testSearchApiURL() {
        let expectedTerm = "testArtist"
        let expectedEntity = "musicArtist"
        let sut = ItunesClient.SearchArtistEndPoint(searchText: expectedTerm)
        
        let urlComponents = sut.urlComponents
        
        XCTAssertEqual(urlComponents.scheme, "https")
        XCTAssertEqual(urlComponents.host, "itunes.apple.com")
        XCTAssertEqual(urlComponents.path, "/search")
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "term"), expectedTerm)
        XCTAssertEqual(urlComponents.queryItems?.valueFor(key: "entity"), expectedEntity)

    }
    
}
