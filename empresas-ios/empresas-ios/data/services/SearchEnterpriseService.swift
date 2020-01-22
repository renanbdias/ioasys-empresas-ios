//
//  SearchEnterpriseService.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

protocol SearchEnterpriseNetworkInterface {
    
    func search(text: String) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

final class SearchEnterpriseService: Service<SearchEnterpriseNetworkInterface>, SearchEnterpriseServiceInterface {
    
    func search(text: String) -> AnyPublisher<Result<[Enterprise], Error>, Never> {
        network.search(text: text)
            .map(\.data)
            .decode(type: EnterpriseResponse.self, decoder: jsonDecoder)
            .map { .success($0.enterprises) }
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
