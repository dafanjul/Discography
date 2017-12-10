//
//  AlbumCollectionViewCell.swift
//  Discography
//
//  Created by Dario Fanjul on 07/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    //MARK: - Private
    private let cornerRadius: CGFloat = 4.0
    private var viewModel: AlbumCellViewModel?
    
    //MARK: Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = UIImage(named: "albumPlaceholder")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = cornerRadius
    }
    
    //MARK: - Public
    func configure(with viewModel: AlbumCellViewModel) {
        self.viewModel = viewModel
        loadInfo()
        viewModel.didUpdate = { [weak self] in
            self?.loadInfo()
        }
    }
    
    //MARK: Helpers
    private func loadInfo() {
        titleLabel.text = viewModel?.title
        subtitleLabel.text = viewModel?.year
        if let imageData = viewModel?.imageData {
            albumImageView.image = UIImage(data: imageData)
        }
    }
    
}
