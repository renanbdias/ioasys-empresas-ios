//
//  LoginViewController.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var passwordContainerView: UIView!
    
    private let enterButton = UIButton(frame: .zero)
    
    private let emailViewModel = TextFieldWithIconViewModel(placeHolder: "E-mail", icon: #imageLiteral(resourceName: "icEmail"))
    private let passwordViewModel = TextFieldWithIconViewModel(placeHolder: "Senha", icon: #imageLiteral(resourceName: "icCadeado"))
    
    private var enterButtonbottomConstraint = NSLayoutConstraint()
    
    var cancelables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLayout()
        addEnterButton()
        listenToKeyboardEvents(cancelablesSet: &cancelables)
        addFormFields()
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(viewTap)
    }
    
    @objc func didTapEnterButton() {
        // MARK: TODO
        print("TODO")
        view.endEditing(true)
    }
    
    @objc func didTapView() {
        view.endEditing(true)
    }
}

extension LoginViewController: KeyboardListanable {
    
    func keyboardDidUpdate(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height

        enterButtonbottomConstraint.constant = -keyboardHeight + 12

        UIView.animate(withDuration: 0.5, animations: view.layoutIfNeeded)
    }
}

// MARK: - UI
private extension LoginViewController {
    
    func applyLayout() {
        logoLayout()
        welcomeLayout()
        descriptionLayout()
        enterButtonLayout()
        
        view.backgroundColor = .beige
    }
    
    func logoLayout() {
        logoImageView.image = #imageLiteral(resourceName: "logoHome")
        logoImageView.tintColor = .darkishPink
    }
    
    func welcomeLayout() {
        welcomeLabel.text = "BEM-VINDO AO EMPRESAS"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func descriptionLayout() {
        descriptionLabel.text = "Lorem ipsum dolor sit amet, contetur adipiscing elit. Nunc accumsan."
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
    }
    
    func enterButtonLayout() {
        enterButton.backgroundColor = .greenyBlue
        enterButton.setTitle("ENTRAR", for: .normal)
        enterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        enterButton.tintColor = .white
        enterButton.layer.cornerRadius = 6
    }
}

// MARK: - Form
private extension LoginViewController {
    
    func addFormFields() {
        addEmailField()
        addPasswordField()
    }
    
    func addEmailField() {
        let emailField = TextFieldWithIconView.loadNib(with: emailViewModel)
        emailField.snapToEdges(of: emailContainerView)
        emailContainerView.backgroundColor = .clear
    }
    
    func addPasswordField() {
        let passwordField = TextFieldWithIconView.loadNib(with: passwordViewModel)
        passwordField.snapToEdges(of: passwordContainerView)
        passwordContainerView.backgroundColor = .clear
    }
    
    func addEnterButton() {
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(enterButton)
        
        enterButtonbottomConstraint = enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21)
        
        NSLayoutConstraint.activate([
            enterButton.heightAnchor.constraint(equalToConstant: 52),
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            enterButtonbottomConstraint
        ])
        
        enterButton.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
    }
}
