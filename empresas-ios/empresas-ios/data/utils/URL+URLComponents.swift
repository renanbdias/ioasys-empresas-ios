//
//  URL+URLComponents.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        var queryItems = urlComponents.queryItems ??  []

        let queryItem = URLQueryItem(name: queryItem, value: value)

        queryItems.append(queryItem)

        urlComponents.queryItems = queryItems

        return urlComponents.url ?? self
    }
}
