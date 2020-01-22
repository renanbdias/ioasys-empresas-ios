//
//  TextFieldWithIconViewModel.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit
import Combine

final class TextFieldWithIconViewModel: TextFieldWithIconViewInterface {
    
    var text: String = ""
    
    let placeHolder: String
    let icon: UIImage
    let keyboardType: UIKeyboardType
    let isSecureTextEntry: Bool
    
    init(placeHolder: String, icon: UIImage, keyboardType: UIKeyboardType = .default, isSecureTextEntry: Bool = false) {
        self.placeHolder = placeHolder
        self.icon = icon
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
    }
}
