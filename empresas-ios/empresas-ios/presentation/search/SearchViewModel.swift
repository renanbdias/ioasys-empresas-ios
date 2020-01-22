//
//  SearchViewModel.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 21/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Combine

protocol SearchEnterpriseServiceInterface {
    
//    func login(email: String, password: String) -> AnyPublisher<Result<Investor, Error>, Never>
//    func search(text: String) -> AnyPublisher<Result<>>
}

final class SearchViewModel {
    
    @Published var searchText: String = ""
    
//    @Published var cellViewModels: [CompanyTableViewCellInterface] = []
    var cellViewModels: [EnterpriseTableViewCellInterface] = []
    
//    private let service: SearchEnterpriseServiceInterface
    
//    init(service: SearchEnterpriseServiceInterface) {
//        self.service = service
//    }
}

// MARK: - SearchViewInterface
extension SearchViewModel: SearchViewInterface {
    
//    var cellViewModels: [CompanyTableViewCellInterface] {
//
//    }
    
    var numberOfRows: Int {
        cellViewModels.count
    }
    
    var reload: AnyPublisher<Void, Never> {
//        $cellViewModels.map { _ in }.eraseToAnyPublisher()
//        $searchText.flatMap {  }
        Just(()).eraseToAnyPublisher()
    }
    
    func textDidChange(_ text: String) {
        searchText = text
    }
}
