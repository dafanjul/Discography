//
//  ArtistsViewController.swift
//  Discography
//
//  Created by Dario Fanjul on 06/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import UIKit

class ArtistsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private
    private let estimatedRowHeight: CGFloat = 140.0
    private let cellIdentifier = "Artist"
    
    //MARK: - Properties
    var viewModel: ArtistsViewModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? DiscographyViewController,
            let nextViewModel = sender as? DiscographyViewModelType {
            nextViewController.viewModel = nextViewModel
        }
    }
    
    //MARK: Helpers
    fileprivate func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
    }
    
}

extension ArtistsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfElements ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let cellViewModel = viewModel?.viewModel(for: indexPath.row),
            let cell = cell as? ArtistTableViewCell {
            cellViewModel.isActive = true
            cellViewModel.didUpdate = {
                guard let cell = tableView.cellForRow(at: indexPath) as? ArtistTableViewCell else {
                    return
                }
                cell.loadInfo()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            cell.configure(viewModel: cellViewModel)
        }
        
        return cell
    }
    
}

extension ArtistsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.element(index: indexPath.row, isActive: false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let nextViewModel = viewModel?.discographyViewModel(for: indexPath.row) {
            performSegue(withIdentifier: "DiscographyViewController", sender: nextViewModel)
        }
    }
    
}

extension ArtistsViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            viewModel?.element(index: indexPath.row, isActive: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { (indexPath) in
            viewModel?.element(index: indexPath.row, isActive: false)
        }
    }
    
}
