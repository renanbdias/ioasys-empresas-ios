//
//  LoginViewModel.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 21/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol LoginServiceProtocol {
    
    func login(email: String, password: String) -> AnyPublisher<Result<Investor, Error>, Never>
}

final class LoginViewModel {
    
    private let loginPublisher = PassthroughSubject<(email: String, password: String), Never>()
    private let showAlertPublisher = PassthroughSubject<UIAlertController, Never>()
    
    private let service: LoginServiceProtocol
    
    let emailViewModel = TextFieldWithIconViewModel(placeHolder: "E-mail", icon: #imageLiteral(resourceName: "icEmail"), keyboardType: .emailAddress)
    let passwordViewModel = TextFieldWithIconViewModel(placeHolder: "Senha", icon: #imageLiteral(resourceName: "icCadeado"), isSecureTextEntry: true)
    
    @Published var makingRequestRelay: Bool = false
    
    init(service: LoginServiceProtocol) {
        self.service = service
    }
    
    private func showAlertFor(error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        showAlertPublisher.send(alert)
    }
}

// MARK: - LoginViewInterface
extension LoginViewModel: LoginViewInterface {
    
    var loginRequest: AnyPublisher<Result<Void, Never>, Never> {
        loginPublisher.flatMap { [unowned self] (form) in self.service.login(email: form.email, password: form.password) }
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] (result) in
                if case .failure(let error) = result {
                    self?.showAlertFor(error: error)
                }
                self?.makingRequestRelay = false
            })
            .map { _ in Result.success(()) }
            .eraseToAnyPublisher()
    }
    
    var showAlert: AnyPublisher<UIAlertController, Never> {
        showAlertPublisher.eraseToAnyPublisher()
    }
    
    var makingRequest: AnyPublisher<Bool, Never> {
        $makingRequestRelay.eraseToAnyPublisher()
    }
        
    var welcome: String {
        "BEM-VINDO AO EMPRESAS"
    }
    
    var description: String {
        "Lorem ipsum dolor sit amet, contetur adipiscing elit. Nunc accumsan."
    }
    
    var buttonTitle: String {
        "ENTRAR"
    }
    
    func didTapEnter() {
        self.makingRequestRelay = true
        loginPublisher.send((email: emailViewModel.text, password: passwordViewModel.text))
    }
}
