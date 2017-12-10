//
//  ArtistViewModelTests.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import XCTest
@testable import Discography

class ArtistViewModelTests: XCTestCase {
    
    var sut: ArtistsViewModel!
    var mockImageDownloader: MockImageDownloader!
    var mockDiscographyManager: MockDiscographyManager!
    
    override func setUp() {
        super.setUp()
        mockDiscographyManager = MockDiscographyManager()
        mockImageDownloader = MockImageDownloader()
    }
    
    override func tearDown() {
        mockDiscographyManager = nil
        mockImageDownloader = nil
        sut = nil
        super.tearDown()
    }
    
    func testViewModel_Creation() {
        let artists = [
            Artist(artistName: "test name", artistId: 123, primaryGenreName: "Test Genre"),
            Artist(artistName: "test name 2", artistId: 1234, primaryGenreName: "Test Genre 2")
        ]
        sut = ArtistsViewModel(artists: artists, discographyManager: mockDiscographyManager, imageDownloader: mockImageDownloader)

        let result = sut.viewModel(for: 0)
        
        XCTAssertEqual(result!.artist, artists.first)
    }
    
    func testViewModel_CreationOutOfBoundShouldReturnNil() {
        let artists = [
            Artist(artistName: "test name", artistId: 123, primaryGenreName: "Test Genre")
        ]
        sut = ArtistsViewModel(artists: artists, discographyManager: mockDiscographyManager, imageDownloader: mockImageDownloader)
        
        let result = sut.viewModel(for: 1)
        
        XCTAssertNil(result)
    }
    
    func testViewModel_ShouldActivateElement() {
        let artists = [
            Artist(artistName: "test name", artistId: 123, primaryGenreName: "Test Genre")
        ]
        sut = ArtistsViewModel(artists: artists, discographyManager: mockDiscographyManager, imageDownloader: mockImageDownloader)
        
        XCTAssertFalse(sut.viewModel(for: 0)!.isActive)
        sut.element(index: 0, isActive: true)
        XCTAssertTrue(sut.viewModel(for: 0)!.isActive)
    }
    
    func testViewModel_CreateDiscographyViewModel() {
        let artists = [
            Artist(artistName: "test name", artistId: 123, primaryGenreName: "Test Genre")
        ]
        
        let config = ArtistsViewModel.Configuration(discographyViewModelType: MockDiscographyViewModel.self)
        sut = ArtistsViewModel(artists: artists, discographyManager: mockDiscographyManager, imageDownloader: mockImageDownloader, configurator: config)
        
        let result = sut.discographyViewModel(for: 0) as? MockDiscographyViewModel

        XCTAssertTrue(result!.initCalled)
        XCTAssertEqual(result?.artistReceived, artists.first)
    }
}


