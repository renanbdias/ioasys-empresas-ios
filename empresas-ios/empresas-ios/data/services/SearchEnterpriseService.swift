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

final class SearchEnterpriseService: Service<SearchEnterpriseNetworkInterface> {
    
//    private let network: SearchEnterpriseNetworkInterface
//
//    init(network: SearchEnterpriseNetworkInterface) {
//        self.network = network
//    }
}
