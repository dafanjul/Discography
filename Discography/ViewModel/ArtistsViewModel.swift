//
//  ArtistsViewModel.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

final class ArtistsViewModel {
    
    //MARK: - Private
    private let artists: [ArtistCellViewModel]
    private let discographyManager: DiscographyManagerType
    private let imageDownloader: ImageDownloaderType
    private let configuration: Configuration
    
    //MARK: - Properties
    var numberOfElements: Int {
        return artists.count
    }
    
    //MARK: - Lifecycle
    init(artists: [Artist], discographyManager: DiscographyManagerType, imageDownloader: ImageDownloaderType, configurator: Configuration = Configuration()) {
        self.configuration = configurator
        self.discographyManager = discographyManager
        self.artists = artists.map({ ArtistCellViewModel(artist: $0, discographyManager: discographyManager) })
        self.imageDownloader = imageDownloader
    }
    
    deinit {
        discographyManager.cancelAllRequests()
    }

    //MARK: - Actions
    func viewModel(for index: Int) -> ArtistCellViewModel? {
        guard index < artists.count else {
            return nil
        }
        
        return artists[index]
    }
    
    func element(index: Int, isActive active: Bool) {
        let artist = artists[index]
        artist.isActive = active
    }
    
    func discographyViewModel(for index: Int) -> DiscographyViewModelType? {
        guard index < artists.count else {
                return nil
        }
        let artist = artists[index].artist
        
        return configuration.discographyViewModelType.init(artist: artist,
                                                           discographyManager: discographyManager,
                                                           imageDownloader: imageDownloader)
    }
    
}

extension ArtistsViewModel {
    
    struct Configuration {
        let discographyViewModelType: DiscographyViewModelType.Type

        init(discographyViewModelType: DiscographyViewModelType.Type? = nil) {
            self.discographyViewModelType = discographyViewModelType ?? DiscographyViewModel.self
        }
    }
    
}
