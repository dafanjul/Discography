//
//  DiscographyViewModel.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

final class DiscographyViewModel {
    
    //MARK: - Private
    private var discography: [AlbumCellViewModel]?
    private var discographyManager: DiscographyManagerType
    private var artist: Artist
    private var imageDownloader: ImageDownloaderType
    
    //MARK: - Properties
    var isWaitingResponse = false {
        didSet {
            didChangeLoading?(isWaitingResponse)
        }
    }
    var artistName: String {
        return artist.artistName
    }
    var numberOfElements: Int {
        return discography?.count ?? 0
    }
    var isEmptyData = false {
        didSet {
            if isEmptyData {
                didNoData?()
            }
        }
    }
    var emptyMessage: String {
        return "No albums"
    }
    
    //MARK: - Events
    var didUpdate: (() -> Void)?
    var didError: ((String) -> Void)?
    var didNoData: (() -> Void)?
    var didChangeLoading: ((Bool) -> Void)?
    
    //MARK: - Lifecycle
    init(artist: Artist, discographyManager: DiscographyManagerType, imageDownloader: ImageDownloaderType) {
        self.discographyManager = discographyManager
        self.artist = artist
        self.imageDownloader = imageDownloader
        requestDiscography(artistId: artist.artistId, imageDownloader: imageDownloader)
    }
    
    deinit {
        discographyManager.cancelRequest(for: artist.artistId)
    }
    
    //MARK: - Actions
    func viewModel(for index: Int) -> AlbumCellViewModel? {
        guard let count = discography?.count,
            index < count else {
                
                return nil
        }
        
        return discography?[index]
    }
    
    func element(index: Int, isActive active: Bool) {
        let album = discography?[index]
        album?.isActive = active
    }
    
    func reloadData() {
        guard !isWaitingResponse else {
            return
        }
        requestDiscography(artistId: artist.artistId, imageDownloader: imageDownloader)
    }
    
    //MARK: - Helpers
    fileprivate func requestDiscography(artistId: Int, imageDownloader: ImageDownloaderType) {
        isWaitingResponse = true
        discographyManager.requestDiscography(for: artistId) { [weak self] (albums, error) in
            self?.isWaitingResponse = false
            guard error == nil,
                let albums = albums else {
                    self?.didError?("Error downloading data, please try again later")
                    return
            }
            self?.discography = albums.map({ AlbumCellViewModel(album: $0, imageDownloader: imageDownloader) })
            if let elements = self?.discography?.count,
                elements > 0 {
                self?.didUpdate?()
            } else {
                self?.isEmptyData = true
            }
        }
    }
}

extension DiscographyViewModel: DiscographyViewModelType {}
