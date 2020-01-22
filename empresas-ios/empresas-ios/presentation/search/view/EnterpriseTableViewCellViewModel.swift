//
//  EnterpriseTableViewCellViewModel.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

struct EnterpriseTableViewCellViewModel: EnterpriseTableViewCellInterface {
    
    let shortenedName: String
    let name: String
    let type: String
    let country: String
}

extension EnterpriseTableViewCellViewModel {
    
    init(enterprise: Enterprise) {
        self.shortenedName = "E1" // MARK: - TODO
        self.name = enterprise.enterpriseName
        self.type = enterprise.enterpriseType.enterpriseTypeName
        self.country = enterprise.country
    }
}
