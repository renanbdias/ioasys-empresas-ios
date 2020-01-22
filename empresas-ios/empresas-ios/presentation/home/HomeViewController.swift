//
//  HomeViewController.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        applyLayout()
    }
    
    @objc func didTapSearchButton() {
        let network = EnterpriseRoutes()
        let service = SearchEnterpriseService(network: network)
        let viewModel = SearchViewModel(service: service)
        let searchViewController = SearchViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

// MARK: - UI
private extension HomeViewController {
    
    func applyLayout() {
        view.backgroundColor = .beige
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logoHome").withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.navigationItem.titleView = imageView
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .darkishPink
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
}
