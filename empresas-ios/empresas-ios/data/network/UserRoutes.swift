//
//  UserRoutes.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

final class UserRoutes: API {
    
    private var url: URL {
        baseURL.appendingPathComponent("/users")
    }
}

// MARK: - LoginNetworkProtocol
extension UserRoutes: LoginNetworkProtocol {
    
    func login(email: String, password: String) -> AnyPublisher<APIResponse, URLError> {
        post(url: url.appendingPathComponent("auth/sign_in"), body: ["email": email, "password": password])
    }
}

