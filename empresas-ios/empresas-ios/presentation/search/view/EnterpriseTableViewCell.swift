//
//  EnterpriseTableViewCell.swift
//  empresas-ios
//
//  Created by Renan Benatti Dias on 21/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import UIKit

protocol EnterpriseTableViewCellInterface {
    
    var shortenedName: String { get }
    var name: String { get }
    var type: String { get }
    var country: String { get }
}

final class EnterpriseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var shortenedNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    func populate(with viewModel: EnterpriseTableViewCellInterface) {
        shortenedNameLabel.text = viewModel.shortenedName
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        countryLabel.text = viewModel.country
    }
}

private extension EnterpriseTableViewCell {
    
    func applyLayout() {
        labelContainerView.backgroundColor = .softGreen
        
        shortenedNameLabel.textColor = .white
        shortenedNameLabel.font = UIFont.systemFont(ofSize: 32)
        shortenedNameLabel.textAlignment = .center
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        typeLabel.font = UIFont.systemFont(ofSize: 15)
        typeLabel.textColor = .warmGrey
        
        countryLabel.font = UIFont.systemFont(ofSize: 15)
        countryLabel.textColor = .warmGrey
    }
}
