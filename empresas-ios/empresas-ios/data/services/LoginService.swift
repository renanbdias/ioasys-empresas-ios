//
//  LoginService.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 21/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

protocol LoginNetworkProtocol {
    
    func login(email: String, password: String) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

final class LoginService: Service<LoginNetworkProtocol> {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

// MARK: - LoginServiceProtocol
extension LoginService: LoginServiceProtocol {
    
    func login(email: String, password: String) -> AnyPublisher<Result<Investor, Error>, Never> {
        network.login(email: email, password: password)
            .handleEvents(receiveOutput: { (data, response) in
                if let httpResponse = response as? HTTPURLResponse {
                    AuthManager.shared.save(headers: httpResponse.allHeaderFields)
                }
            })
            .map(\.data)
            .decode(type: InvestorResponse.self, decoder: jsonDecoder)
            .map { .success($0.investor) }
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
