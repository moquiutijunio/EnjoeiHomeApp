//
//  HomeHeaderView.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 19/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var separetorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        backgroundColor = .clear
        separetorView.backgroundColor = UIColor.lightGray2
    
        messageLabel.text = NSLocalizedString("women.discount.percentage", comment: "")
        messageLabel.font = UIFont.proximaNovaRegularLight(ofSize: 28)
        messageLabel.textAlignment = .left
        messageLabel.textColor = .gray2
    }
}

extension HomeHeaderView {
    
    class func instantiateFromNib() -> HomeHeaderView {
        return UINib(nibName: "HomeHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HomeHeaderView
    }
}
