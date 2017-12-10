//
//  DiscographyViewController.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import UIKit

class DiscographyViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Private
    private let padding: CGFloat = 10.0
    private let cellIdentifier = "Album"
    private let emptyButtonTitle = "Try again"
    weak private var messageView: UIView?
    
    //MARK: - Properties
    var viewModel: DiscographyViewModelType?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel?.artistName
        setupCollectionView(collectionView)
        if let viewModel = viewModel {
            setupViewModel(viewModel)
        }
    }
    
    //MARK: - Helpers
    fileprivate func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
    }
    
    fileprivate func displayAsLoading(_ isLoading: Bool) {
        collectionView.isHidden = isLoading
        messageView?.removeFromSuperview()
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    fileprivate func display(_ message: String, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        collectionView.isHidden = true
        let messageView = MessageView()
        self.messageView = messageView
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.title = message
        messageView.action = action
        messageView.actionTitle = actionTitle
        view.addSubview(messageView)
        messageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        messageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    fileprivate func setupViewModel(_ viewModel: DiscographyViewModelType) {
        var viewModel = viewModel
        displayAsLoading(viewModel.isWaitingResponse)
        if viewModel.isEmptyData == true {
            display(viewModel.emptyMessage)
        }
        viewModel.didUpdate = { [weak self] in
            self?.messageView?.removeFromSuperview()
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
        viewModel.didChangeLoading = { [weak self] isLoading in
            self?.displayAsLoading(isLoading)
        }
        viewModel.didNoData = { [weak self] in
            if let message = self?.viewModel?.emptyMessage {
                self?.display(message)
            }
        }
        viewModel.didError = { [weak self] (message) in
            self?.display(message, actionTitle: self?.emptyButtonTitle) {
                self?.viewModel?.reloadData()
            }
        }
    }

}

extension DiscographyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfElements ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? AlbumCollectionViewCell,
            let cellViewModel = viewModel?.viewModel(for: indexPath.row) {
            cellViewModel.isActive = true
            cell.configure(with: cellViewModel)
        }
        
        return cell
    }
    
}

extension DiscographyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.element(index: indexPath.row, isActive: false)
    }
    
}

extension DiscographyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - padding * 3)/2.0, height: 187)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
}

extension DiscographyViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            viewModel?.element(index: indexPath.row, isActive: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            viewModel?.element(index: indexPath.row, isActive: false)
        }
    }
}

