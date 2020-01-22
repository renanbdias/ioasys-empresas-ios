//
//  SearchViewController.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 21/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit
import Combine

protocol SearchViewInterface {
    
    var cellViewModels: [EnterpriseTableViewCellInterface] { get }
    var numberOfRows: Int { get }
    var reload: AnyPublisher<Void, Never> { get }
    
    func textDidChange(_ text: String)
}

final class SearchViewController: UITableViewController {
    
    private let searchBar = UISearchBar()
    
    private var cancelables = Set<AnyCancellable>()
    
    private let viewModel: SearchViewInterface
    
    init(viewModel: SearchViewInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLayout()
        
        tableView.register(UINib(nibName: "EnterpriseTableViewCell", bundle: nil), forCellReuseIdentifier: "EnterpriseTableViewCell")
        
        viewModel.reload
            .sink { [weak self] in
                self?.tableView.reloadData()
            }
            .store(in: &cancelables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    private func goToDetailsWith(id: Int) {
        let service = DetailsViewService(network: EnterpriseRoutes())
        let viewModel = DetailsViewModel(id: id, service: service)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK: - UI
private extension SearchViewController {
    
    func applyLayout() {
        addSearchBar()
        
        tableView.separatorStyle = .none
        
        navigationController?.navigationBar.barTintColor = .darkishPink
        
        view.backgroundColor = .beige
    }
    
    func addSearchBar() {
        searchBar.placeholder = " Pesquisar"
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = true
        searchBar.tintColor = .gray
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EnterpriseTableViewCell", for: indexPath) as? EnterpriseTableViewCell {
            cell.populate(with: viewModel.cellViewModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goToDetailsWith(id: viewModel.cellViewModels[indexPath.row].id)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidChange(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
