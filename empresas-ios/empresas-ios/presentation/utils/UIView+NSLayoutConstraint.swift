//
//  UIView+NSLayoutConstraint.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit

extension UIView {
    
    func snapToEdges(of view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
