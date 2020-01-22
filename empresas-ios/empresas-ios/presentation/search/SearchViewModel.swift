//
//  SearchViewModel.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 21/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

protocol SearchEnterpriseServiceInterface {
    
    func search(text: String) -> AnyPublisher<Result<[Enterprise], Error>, Never>
}

final class SearchViewModel {
    
    @Published var searchText: String = ""
    
    var cellViewModels: [EnterpriseTableViewCellInterface] = []
    
    private let service: SearchEnterpriseServiceInterface
    
    // MARK: Loading
    
    init(service: SearchEnterpriseServiceInterface) {
        self.service = service
    }
}

// MARK: - SearchViewInterface
extension SearchViewModel: SearchViewInterface {
    
    var numberOfRows: Int {
        cellViewModels.count
    }
    
    var reload: AnyPublisher<Void, Never> {
        $searchText.debounce(for: 0.5, scheduler: RunLoop.main)
            .filter { !$0.isEmpty && $0.count >= 3 }
            .flatMap { [unowned self] in self.service.search(text: $0) }
            .receive(on: RunLoop.main)
            .map {
                switch $0 {
                case .success(let enterprises):
                    // MARK: TODO empty cells
                    return enterprises.map(EnterpriseTableViewCellViewModel.init(enterprise:))
                    
                case .failure(let error):
                    // MARK: Error cell
                    // Log on crashlytics?
                    print(error.localizedDescription)
                    return []
                }
            }
            .handleEvents(receiveOutput: { [weak self] in
                self?.cellViewModels = $0
            })
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    func textDidChange(_ text: String) {
        searchText = text
    }
}
