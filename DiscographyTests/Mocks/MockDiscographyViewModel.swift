//
//  MockDiscographyViewModel.swift
//  DiscographyTests
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation
@testable import Discography

class MockDiscographyViewModel: DiscographyViewModelType {
    
    //MARK: - Test Properties
    var artistReceived: Artist?
    var discographyManagerReceived: DiscographyManagerType?
    var imageDownloaderReceived: ImageDownloaderType?
    var initCalled = false
    
    //MARK: - DiscographyViewModelType
    var artistName: String
    var isWaitingResponse: Bool
    var numberOfElements: Int
    var isEmptyData: Bool
    var emptyMessage: String
    
    func viewModel(for index: Int) -> AlbumCellViewModel? {
        return nil
    }

    func reloadData() {
        
    }
    
    func element(index: Int, isActive active: Bool) {
        
    }
    
    var didUpdate: (() -> Void)?
    
    var didError: ((String) -> Void)?
    
    var didNoData: (() -> Void)?
    
    var didChangeLoading: ((Bool) -> Void)?
    
    required init(artist: Artist, discographyManager: DiscographyManagerType, imageDownloader: ImageDownloaderType) {
        self.artistReceived = artist
        self.discographyManagerReceived = discographyManager
        self.imageDownloaderReceived = imageDownloader
        self.initCalled = true
        
        //Required
        artistName = ""
        isWaitingResponse = false
        numberOfElements = 0
        isEmptyData = false
        emptyMessage = ""
    }
    
}
