//
//  MessageCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class MessageSectionModel: NSObject {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
}

class MessageCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: MessageSectionModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        
        messageLabel.font = UIFont.systemFont(ofSize: 14) //TODO verificar a font correta
        messageLabel.textAlignment = .center
        messageLabel.textColor = .black
    }
    
    func bindIn(viewModel: MessageSectionModel) {
        messageLabel.text = viewModel.message
        
        self.viewModel = viewModel
    }
}
