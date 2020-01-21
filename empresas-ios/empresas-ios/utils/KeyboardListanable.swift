//
//  KeyboardListanable.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine

protocol KeyboardListanable {
    
    func listenToKeyboardEvents(cancelablesSet: inout Set<AnyCancellable>)
    func keyboardDidUpdate(notification: Notification)
}
