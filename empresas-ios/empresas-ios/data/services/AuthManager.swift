//
//  AuthManager.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 21/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation

protocol AuthManagerInterface {
    
    var authenticated: Bool { get }
    
    var accessToken: String? { get }
    var client: String? { get }
    var uid: String? { get }
    
    func save(headers: [AnyHashable: Any])
    func clearHeaders()
}

final class AuthManager {
    
    static let shared: AuthManagerInterface = AuthManager()
    
    private func save(key: String, value: Any?) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    private func clear(for key: String) {
        UserDefaults.standard.set(nil, forKey: key)
    }
}

// MARK: - AuthManagerInterface
extension AuthManager: AuthManagerInterface {
    
    var authenticated: Bool {
        accessToken != nil && client != nil && uid != nil
    }
    
    var accessToken: String? {
        UserDefaults.standard.value(forKey: "access-token") as? String
    }
    
    var client: String? {
        UserDefaults.standard.value(forKey: "client") as? String
    }
    
    var uid: String? {
        UserDefaults.standard.value(forKey: "uid") as? String
    }
    
    func save(headers: [AnyHashable: Any]) {
        save(key: "access-token", value: headers["access-token"])
        save(key: "client", value: headers["client"])
        save(key: "uid", value: headers["uid"])
    }
    
    func clearHeaders() {
        clear(for: "access-token")
        clear(for: "client")
        clear(for: "uid")
    }
}
