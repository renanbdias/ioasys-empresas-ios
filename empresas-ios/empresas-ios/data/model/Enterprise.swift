//
//  Enterprise.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

struct ListEnterpriseResponse: Codable {
    
    let enterprises: [Enterprise]
}

struct EnterpriseResponse: Codable {
    
    let enterprise: Enterprise
}

struct Enterprise: Codable {
    
    let id: Int
    let emailEnterprise: String?
    let facebook: String?
    let twitter: String?
    let linkedin: String?
    let phone: String?
    let ownEnterprise: Bool
    let enterpriseName: String
    let photo: String?
    let description: String
    let city: String
    let country: String
    let value: Int
    let sharePrice: Double
    let enterpriseType: EnterpriseType
}

