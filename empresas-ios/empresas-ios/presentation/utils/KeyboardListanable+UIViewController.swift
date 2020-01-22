//
//  KeyboardListanable+UIViewController.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit
import Combine

extension KeyboardListanable where Self: UIViewController {
    
    func listenToKeyboardEvents(cancelablesSet: inout Set<AnyCancellable>) {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .sink(receiveValue: keyboardDidUpdate(notification:))
            .store(in: &cancelablesSet)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)
            .sink(receiveValue: keyboardDidUpdate(notification:))
            .store(in: &cancelablesSet)
    }
}
