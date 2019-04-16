//
//  LoadingCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit


class LoadingCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var activityIndicationView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        backgroundColor = .clear
        
        activityIndicationView.color = .primaryColor
        activityIndicationView.startAnimating()
    }
}
