//
//  DiscographyViewModelType.swift
//  Discography
//
//  Created by Dario Fanjul on 09/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import Foundation

protocol DiscographyViewModelType {
    
    //Properties
    var artistName: String { get }
    var isWaitingResponse: Bool { get }
    var numberOfElements: Int { get }
    var isEmptyData: Bool { get }
    var emptyMessage: String { get }
    
    //Actions
    func viewModel(for index: Int) -> AlbumCellViewModel?
    func reloadData()
    func element(index: Int, isActive active: Bool)
    
    //Events
    var didUpdate: (() -> Void)? { get set }
    var didError: ((String) -> Void)? { get set }
    var didNoData: (() -> Void)? { get set }
    var didChangeLoading: ((Bool) -> Void)? { get set }
    
    init(artist: Artist, discographyManager: DiscographyManagerType, imageDownloader: ImageDownloaderType)
    
}
