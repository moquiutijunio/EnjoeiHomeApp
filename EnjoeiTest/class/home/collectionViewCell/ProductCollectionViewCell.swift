//
//  ProductCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import Kingfisher

class ProductViewModel: NSObject {
    
    let product: Product
    let title: String
    let details: String
    let likeCount: String
    let userAvatarURL: URL
    let photoURL: URL?
    var attributedText: NSMutableAttributedString?
    
    init(product: Product) {
        self.product = product
        self.title = product.title
        self.details = product.size != nil ? "R$ \(product.price) - tam \(product.size!)" : "R$ \(product.price)"
        self.likeCount = "\(product.likesCount ?? 0)"
        self.userAvatarURL = product.userImage.imageURL
        self.photoURL = product.images.first?.imageURL
        
        super.init()
        
        let text = self.details
        attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
        if let size = product.size {
            let range = (text as NSString).range(of: "- tam \(size)")
            attributedText?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray2, range: range)
        }
    }
}

class ProductCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarContainerView: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeContainerView: UIView!
    
    var viewModel: ProductViewModel!
    
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
        
        self.viewModel = viewModel
    }
}
