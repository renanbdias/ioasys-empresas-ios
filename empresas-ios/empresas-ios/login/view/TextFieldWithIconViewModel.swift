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
    
    var placeHolder: String
    var icon: UIImage
    
    init(placeHolder: String, icon: UIImage) {
        self.placeHolder = placeHolder
        self.icon = icon
    }
}
