//
//  DetailsViewModel.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

protocol DetailsViewServiceInterface {
    
    func getEnterpriseWith(id: Int) -> AnyPublisher<Result<Enterprise, Error>, Never>
}

final class DetailsViewModel {
    
    private let id: Int
    private let service: DetailsViewServiceInterface
    
    private var enterprise: Enterprise?
    
    private let getEnterpriseSubject = PassthroughSubject<Int, Never>()
    
    // MARK: Todo loading...
    
    init(id: Int, service: DetailsViewServiceInterface) {
        self.id = id
        self.service = service
    }
}

// MARK: - DetailsViewInterface
extension DetailsViewModel: DetailsViewInterface {

    var title: String {
        enterprise?.enterpriseName ?? ""
    }

    var shortenedName: String {
        "E1"    // MARK: TODO
    }

    var description: String {
        enterprise?.description ?? ""
    }
    
    var reloadUI: AnyPublisher<Void, Never> {
        getEnterpriseSubject.flatMap { [unowned self] id in self.service.getEnterpriseWith(id: id) }
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] (result) in
                switch result {
                case .success(let enterprise):
                    self?.enterprise = enterprise
                case .failure(let error):
                    // MARK: Show error
                    print(error.localizedDescription)
                }
            })
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        getEnterpriseSubject.send(id)
    }
}
