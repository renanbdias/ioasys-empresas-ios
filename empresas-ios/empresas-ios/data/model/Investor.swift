//
//  Investor.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation

struct InvestorResponse: Codable {
    
    let investor: Investor
}

struct Investor: Codable {
    
    let id: Int
    let investorName: String
    let email: String
    let city: String
    let country: String
    let balance: Double
    let photo: String
//    let portfolio:
    let portfolioValue : Double
    let firstAccess: Bool
    let superAngel: Bool
}
