//
//  ProductCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarContainerView: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyLayout()
    }
    
    private func applyLayout() {
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray2.cgColor
        
        avatarContainerView.layer.borderWidth = 0.5
        avatarContainerView.layer.borderColor = UIColor.lightGray2.cgColor
        
        likeContainerView.layer.borderWidth = 0.5
        likeContainerView.layer.borderColor = UIColor.lightGray2.cgColor
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .lightGray2
        photoImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.proximaNovaRegularLight(ofSize: 16)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .gray2
        
        detailsLabel.font = UIFont.proximaNovaRegular(ofSize: 14)
        detailsLabel.textAlignment = .center
        detailsLabel.textColor = .primaryColor
        
        avatarImageView.backgroundColor = .lightGray2
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
        avatarImageView.clipsToBounds = true
        
        likeImageView.image = UIImage(named: "ic_like")
        likeImageView.contentMode = .scaleAspectFit
        
        likeCountLabel.font = UIFont.proximaNovaRegular(ofSize: 14)
        likeCountLabel.textColor = .gray2
    }
    
    func bindIn(viewModel: ProductViewModel) {
        
        titleLabel.text = viewModel.title
        detailsLabel.text = viewModel.details
        likeCountLabel.text = viewModel.likeCount
        avatarImageView.kf.setImage(with: viewModel.userAvatarURL)
        photoImageView.kf.setImage(with: viewModel.photoURL)
        detailsLabel.attributedText = viewModel.attributedText
    }
}
