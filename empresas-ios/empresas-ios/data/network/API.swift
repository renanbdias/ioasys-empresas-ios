//
//  API.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

typealias APIResponse = (data: Data, response: URLResponse)

protocol API {
    
    var baseURL: URL { get }
    
    func get(url: URL, cachePolicy: URLRequest.CachePolicy, queries: [String: String]) -> AnyPublisher<APIResponse, URLError>
    func post(url: URL, body: [String: Any]) -> AnyPublisher<APIResponse, URLError>
}

extension API {
    
    var baseURL: URL {
        URL(string: "https://empresas.ioasys.com.br/api/v1")!
    }
    
    func get(url: URL, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, queries: [String: String] = [:]) -> AnyPublisher<APIResponse, URLError> {
        
        // MARK: Refactor later
        var finalURL = url
        
        if !queries.isEmpty {
            queries.forEach { finalURL = url.appending($0, value: $1) }
        }
        
        var request = URLRequest(url: finalURL, cachePolicy: cachePolicy)
        
        // MARK: Refactor later
        let authManager = AuthManager.shared
        
        if authManager.authenticated {
            request.setValue(authManager.accessToken, forHTTPHeaderField: "access-token")
            request.setValue(authManager.client, forHTTPHeaderField: "client")
            request.setValue(authManager.uid, forHTTPHeaderField: "uid")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .eraseToAnyPublisher()
    }
    
    func post(url: URL, body: [String: Any] = [:]) -> AnyPublisher<APIResponse, URLError> {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        
        request.httpBody = bodyData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .eraseToAnyPublisher()
    }
}
