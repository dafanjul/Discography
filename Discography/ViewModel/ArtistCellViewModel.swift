//
//  ArtistCellViewModel.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

final class ArtistCellViewModel {
    
    //MARK: - Private
    private let discographyManager: DiscographyManagerType
    private var albums: [Album]?
    private let detailedAlbums = 2
    
    //MARK: - Properties
    let artist: Artist
    var isActive = false {
        didSet {
            if isActive,
                albums == nil {
                discographyManager.requestDiscography(for: artist.artistId, completion: { [weak self] (albums, error) in
                    guard error == nil else {
                        //Should display something different in the cell?
                        return
                    }
                    self?.albums = albums
                    self?.didUpdate?()
                })
            } else if !isActive {
                discographyManager.cancelRequest(for: artist.artistId)
            }
            
        }
    }
    var name: String {
        return artist.artistName
    }
    var firstAlbum: String? {
        return albums?.first?.collectionName
    }
    var secondAlbum: String? {
        guard let albumCount = albums?.count,
            albumCount >= detailedAlbums else {
                return nil
        }
        
        return albums?[1].collectionName
    }
    var hasMoreTitles: Bool {
        if let count = albums?.count,
            count > detailedAlbums {
            return true
        }
        
        return false
    }
    var genre: String? {
        return artist.primaryGenreName
    }

    //MARK: - Events
    var didUpdate: (() -> Void)?
    
    //MARK: - Lifecycle
    init(artist: Artist, discographyManager: DiscographyManagerType) {
        self.artist = artist
        self.discographyManager = discographyManager
    }
    
}
