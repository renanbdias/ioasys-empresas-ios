//
//  Service.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation

class Service<T> {
    
    let network: T
    
    init(network: T) {
        self.network = network
    }
}
