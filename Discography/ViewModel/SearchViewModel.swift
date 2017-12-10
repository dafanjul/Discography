//
//  SearchViewModel.swift
//  Discography
//
//  Created by Dario Fanjul on 05/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

final class SearchViewModel {
    
    //MARK: - Private
    private let client: APIClientType

    //MARK: - Events
    var didChangeLoadingStatus: ((Bool)  -> Void)?
    var didReceiveData: ((ArtistsViewModel) -> Void)?
    var didError: ((String, String) -> Void)?

    //MARK: - Lifecycle
    init(apiClient: APIClientType) {
        self.client = apiClient
    }
    
    //MARK: - Actions
    func searchArtist(text: String?) {
        guard let text = text else {
            return
        }
        didChangeLoadingStatus?(true)
        client.searchArtist(with: text) { [weak self] (artists, error) in
            self?.didChangeLoadingStatus?(false)
            guard error == nil,
                let artists = artists,
                let strongSelf = self else {
                self?.didError?("Error Downloading Data", "Please try again later")
                return
            }
            let imageDownloader = ImageDownloader(cache: ImageCacheType())
            let discographyManager = DiscographyManager(client: strongSelf.client)
            let newViewModel = ArtistsViewModel(artists: artists, discographyManager: discographyManager, imageDownloader: imageDownloader)
            strongSelf.didReceiveData?(newViewModel)
        }
    }
    
}
