//
//  TextFieldWithIconView.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit
import Combine

protocol TextFieldWithIconViewInterface {
    
    var placeHolder: String { get }
    var icon: UIImage { get }
    var text: String { get set }
    var keyboardType: UIKeyboardType { get }
    var isSecureTextEntry: Bool { get }
}

final class TextFieldWithIconView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    private var viewModel: TextFieldWithIconViewInterface?
    private var cancellables = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    private func bind(viewModel: TextFieldWithIconViewInterface) {
        cancellables = Set<AnyCancellable>()
        
        iconImageView.image = viewModel.icon.withRenderingMode(.alwaysTemplate)
        textField.placeholder = viewModel.placeHolder
        textField.keyboardType = viewModel.keyboardType
        textField.isSecureTextEntry = viewModel.isSecureTextEntry
        
        textField.publisher(for: \.text)
            .filter { $0 != nil }
            .map { $0! }
            .sink { [unowned self] (text) in
                self.viewModel?.text = text
            }
            .store(in: &cancellables)
        
        self.viewModel = viewModel
    }
}

// MARK: - UI
private extension TextFieldWithIconView {
    
    func applyLayout() {
        textField.borderStyle = .none
        textField.tintColor = .charcoalGrey
        
        iconImageView.tintColor = .mediumPink
        
        backgroundColor = .clear
    }
}

extension TextFieldWithIconView {
    
    static func loadNib(with viewModel: TextFieldWithIconViewInterface) -> TextFieldWithIconView {
        let view = UINib(nibName: "TextFieldWithIconView", bundle: nil).instantiate(withOwner: nil).first as! TextFieldWithIconView
        view.bind(viewModel: viewModel)
        return view
    }
}
