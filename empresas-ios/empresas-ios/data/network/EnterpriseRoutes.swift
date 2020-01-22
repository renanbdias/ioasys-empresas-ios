//
//  EnterpriseRoutes.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

final class EnterpriseRoutes: API {
    
    private var url: URL {
        baseURL.appendingPathComponent("/enterprises")
    }
}

// MARK: - SearchEnterpriseNetworkInterface
extension EnterpriseRoutes: SearchEnterpriseNetworkInterface {
    
    func search(text: String) -> AnyPublisher<APIResponse, URLError> {
        get(url: url, queries: ["name": text, "enterprise_types": "1"])
    }
}
