//
//  MessageCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        
        messageLabel.font = UIFont.proximaNovaRegular(ofSize: 14)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .gray2
    }
    
    func bindIn(message: String) {
        messageLabel.text = message
    }
}
