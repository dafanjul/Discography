//
//  ArtistTableViewCell.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var firstAlbumLabel: UILabel!
    @IBOutlet weak var secondAlbumLabel: UILabel!
    @IBOutlet weak var moreTitlesLabel: UILabel!
    @IBOutlet weak var discographyLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    //MARK: - Private
    private let cornerRadius: CGFloat = 4.0
    weak private var viewModel: ArtistCellViewModel?

    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = cornerRadius
    }
    
    //MARK: Public
    func configure(viewModel: ArtistCellViewModel) {
        self.viewModel = viewModel
        loadInfo()
    }

    func loadInfo() {
        artistLabel.text = viewModel?.name
        genreLabel.text = viewModel?.genre
        discographyLabel.isHidden = viewModel?.firstAlbum == nil
        firstAlbumLabel.text = viewModel?.firstAlbum
        firstAlbumLabel.isHidden = viewModel?.firstAlbum == nil
        secondAlbumLabel.text = viewModel?.secondAlbum
        secondAlbumLabel.isHidden = viewModel?.secondAlbum == nil
        moreTitlesLabel.isHidden = viewModel?.hasMoreTitles == false
    }
    
}
 
