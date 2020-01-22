//
//  DetailsViewController.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit
import Combine

protocol DetailsViewInterface {
    
    var title: String { get }
    var shortenedName: String { get }
    var description: String { get }
    
    var reloadUI: AnyPublisher<Void, Never> { get }
    
    func viewDidLoad()
}

final class DetailsViewController: ViewController<DetailsViewInterface> {
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var shortenedNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var cancelables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLayout()
        bind()
        
        viewModel.viewDidLoad()
    }
    
    @objc func didTapSearchButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func bind() {
        viewModel.reloadUI
            .sink(receiveValue: reloadUI)
            .store(in: &cancelables)
    }
}

// MARK: - UI
extension DetailsViewController {
    
    func applyLayout() {
        headerContainerView.backgroundColor = .softGreen
        shortenedNameLabel.font = UIFont.systemFont(ofSize: 90)
        shortenedNameLabel.textColor = .white
        shortenedNameLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
    }
    
    func reloadUI() {
        shortenedNameLabel.text = viewModel.shortenedName
        descriptionLabel.text = viewModel.description
        descriptionLabel.numberOfLines = 0
        
        title = viewModel.title
    }
}
