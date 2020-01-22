//
//  DetailsViewService.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

protocol DetailsNetworkInterface {

    func getEnterpriseWith(id: Int) -> AnyPublisher<APIResponse, URLError>
}

final class DetailsViewService: Service<DetailsNetworkInterface>, DetailsViewServiceInterface {
    
    func getEnterpriseWith(id: Int) -> AnyPublisher<Result<Enterprise, Error>, Never> {
        network.getEnterpriseWith(id: id)
            .map(\.data)
            .decode(type: EnterpriseResponse.self, decoder: jsonDecoder)
            .map { .success($0.enterprise) }
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
