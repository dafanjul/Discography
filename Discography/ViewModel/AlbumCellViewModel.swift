//
//  AlbumCellViewModel.swift
//  Discography
//
//  Created by Dario Fanjul on 07/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

final class AlbumCellViewModel {
    
    //MARK: - Private
    private let album: Album
    private let imageDownloader: ImageDownloaderType
    private var imageDataDownloaded: Data?
    private var imageDataDownloadTask: URLSessionDataTask?
    
    //MARK: - Properties
    var isActive = false {
        didSet {
            if isActive,
                imageDataDownloaded == nil,
                imageDataDownloadTask == nil {
                requestImageData()
            } else if imageDataDownloadTask?.state == URLSessionDataTask.State.running,
                !isActive {
                imageDataDownloadTask?.cancel()
            }
        }
    }
    var title: String {
        return album.collectionName
    }
    var year: String? {
        guard let year = album.year else {
            
            return nil
        }
        return String(year)
    }
    var imageData: Data? {
        return imageDataDownloaded
    }
    
    //MARK: - Events
    var didUpdate: (() -> Void)?
    
    //MARK: - Lifecycle
    init(album: Album, imageDownloader: ImageDownloaderType) {
        self.album = album
        self.imageDownloader = imageDownloader
    }
    
    deinit {
        imageDataDownloadTask?.cancel()
    }
    
    //MARK: - Helpers
    private func requestImageData() {
        guard let coverURL = album.coverURL else {
            
            return
        }
        imageDataDownloadTask = imageDownloader.downloadImageData(with: coverURL) { [weak self] (data, error) in
            self?.imageDataDownloadTask = nil
            guard let data = data,
                error == nil else {
                    
                    return
            }
            self?.imageDataDownloaded = data
            self?.didUpdate?()
        }
    }
}
