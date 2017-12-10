//
//  SearchViewController.swift
//  Discography
//
//  Created by Dario Fanjul on 05/12/2017.
//  Copyright © 2017 Dario Fanjul. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var avtivityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var viewModel: SearchViewModel?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        if let viewModel = viewModel {
            setupViewModel(viewModel)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.black
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ArtistsViewController,
            let viewModel = sender as? ArtistsViewModel {
            viewController.viewModel = viewModel
        }
    }
    
    //MARK: - Events
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        viewModel?.searchArtist(text: searchTextField.text)
    }
    
    //MARK: - Helpers
    func setupViewModel(_ viewModel: SearchViewModel) {
        viewModel.didReceiveData = { [weak self] (nextViewModel) in
            self?.performSegue(withIdentifier: "ArtistsViewController", sender: nextViewModel)
        }
        viewModel.didChangeLoadingStatus = { [weak self] (status) in
            if status {
                self?.avtivityIndicator.startAnimating()
            } else {
                self?.avtivityIndicator.stopAnimating()
            }
        }
        viewModel.didError = { [weak self] title, message in
            let errorMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
            errorMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(errorMessage, animated: true, completion: nil)
        }
    }
    
    //MARK: - UI
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel?.searchArtist(text: textField.text)
        
        return true
    }
    
}
