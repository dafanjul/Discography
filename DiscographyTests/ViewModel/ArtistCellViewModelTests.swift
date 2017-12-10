//
//  ArtistCellViewModelTests.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import XCTest
@testable import Discography

class ArtistCellViewModelTests: XCTestCase {
    
    var sut: ArtistCellViewModel!
    var mockDiscographyManager: MockDiscographyManager!
    var expectedArtist: Artist!
    
    override func setUp() {
        super.setUp()
        mockDiscographyManager = MockDiscographyManager()
        expectedArtist = Artist(artistName: "Test Name", artistId: 1234, primaryGenreName: "Test Genre")
        sut = ArtistCellViewModel(artist: expectedArtist, discographyManager: mockDiscographyManager)
    }
    
    override func tearDown() {
        sut = nil
        expectedArtist = nil
        mockDiscographyManager = nil
        super.tearDown()
    }
    
    func testIsActiveShouldCallRequestDiscography() {
        sut.isActive = true
        
        XCTAssertTrue(mockDiscographyManager.requestDiscographyCalled)
        XCTAssertEqual(expectedArtist.artistId, mockDiscographyManager.requestDiscographyArtistId)
    }
    
    func testIsActiveShouldCallCancelRequest() {
        sut.isActive = false
        
        XCTAssertTrue(mockDiscographyManager.cancelRequestCalled)
        XCTAssertEqual(expectedArtist.artistId, mockDiscographyManager.cancelRequestArtistReceived)
    }
    
    func testSuccessDiscographyResults_ShouldCallDidUpdate() {
        sut.isActive = true
        let didUpdateEventCalled = expectation(description: "did update called")

        sut.didUpdate = {
            didUpdateEventCalled.fulfill()
        }

        let response = [Album(collectionName: "Test",
                              releaseDate: "2005-03-01T08:00:00Z",
                              coverURL: nil)]
        mockDiscographyManager.requestDiscographyCompletionReceived?(response, nil)
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testSuccessDiscographyResults_ShouldReturnFirstAlbum() {
        sut.isActive = true
        
        let response = [Album(collectionName: "Test",
                              releaseDate: "2005-03-01T08:00:00Z",
                              coverURL: nil)]
        mockDiscographyManager.requestDiscographyCompletionReceived?(response, nil)
        
        XCTAssertEqual(response.first?.collectionName, sut.firstAlbum)
        XCTAssertEqual(expectedArtist.artistName, sut.name)
        XCTAssertEqual(expectedArtist.primaryGenreName, sut.genre)
        XCTAssertNil(sut.secondAlbum)
        XCTAssertFalse(sut.hasMoreTitles)
    }
    
    func testSuccessDiscographyResults_ShouldReturnTwoAlbum() {
        sut.isActive = true
        
        let response = [Album(collectionName: "Test",
                              releaseDate: "2005-03-01T08:00:00Z",
                              coverURL: nil),
                        Album(collectionName: "Test 2",
                              releaseDate: "2005-03-01T08:00:00Z",
                              coverURL: nil)]
        mockDiscographyManager.requestDiscographyCompletionReceived?(response, nil)
        
        XCTAssertEqual(response.first?.collectionName, sut.firstAlbum)
        XCTAssertEqual(response[1].collectionName, sut.secondAlbum)
        XCTAssertFalse(sut.hasMoreTitles)
    }
    
    func testSuccessDiscographyResults_ShouldReturnMoreThanTwoAlbum() {
        sut.isActive = true
        
        let response = [Album(collectionName: "Test 1",
                              releaseDate: "2005-03-01T08:00:00Z",
                              coverURL: nil),
                        Album(collectionName: "Test 2",
                              releaseDate: "2005-03-01T08:00:00Z",
                              coverURL: nil),
                        Album(collectionName: "Test 3",
                              releaseDate: "2005-03-01T08:00:00Z",
                              coverURL: nil)]
        mockDiscographyManager.requestDiscographyCompletionReceived?(response, nil)
        
        XCTAssertEqual(response.first?.collectionName, sut.firstAlbum)
        XCTAssertEqual(response[1].collectionName, sut.secondAlbum)
        XCTAssertTrue(sut.hasMoreTitles)
    }
    
}
