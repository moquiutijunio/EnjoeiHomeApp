//
//  PhotoHeaderCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoHeaderCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.backgroundColor = .lightGray2
        photoImageView.clipsToBounds = true
    }
    
    func bindIn(imageURL: URL?) {
        photoImageView.kf.setImage(with: imageURL)
    }
}
