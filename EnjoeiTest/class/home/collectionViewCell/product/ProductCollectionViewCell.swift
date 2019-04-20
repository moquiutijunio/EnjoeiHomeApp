//
//  ProductCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

protocol ProductViewModelCallbackProtocol: AnyObject {

    var title: String { get }
    var details: String { get }
    var userAvatarURL: URL? { get }
    var photoURL: URL? { get }
    var attributedText: NSMutableAttributedString? { get }
    
    var likeCount: Observable<String> { get }
    var userLiked: Observable<Bool> { get }
    
    func likeButtonDidTap()
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
    @IBOutlet weak var likeWidthConstraint: NSLayoutConstraint!
    
    private var disposeBag: DisposeBag!
    private var viewModel: ProductViewModelCallbackProtocol!
    
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
        
        likeImageView.image = UIImage(named: "ic_like")?.withRenderingMode(.alwaysTemplate)
        likeImageView.contentMode = .scaleAspectFit
        
        likeCountLabel.font = UIFont.proximaNovaRegular(ofSize: 14)
        likeCountLabel.textAlignment = .left
        likeCountLabel.textColor = .gray2
        
        likeWidthConstraint.constant = (likeContainerView.frame.width/2) + 6
        
        let likeGesture = UITapGestureRecognizer(target: self, action: #selector(likeContainerDidTap))
        likeContainerView.addGestureRecognizer(likeGesture)
    }
    
    func bindIn(viewModel: ProductViewModelCallbackProtocol) {
        disposeBag = DisposeBag()
        
        titleLabel.text = viewModel.title
        detailsLabel.text = viewModel.details
        detailsLabel.attributedText = viewModel.attributedText
        
        viewModel.likeCount
            .bind(to: likeCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.userLiked
            .bind {[weak self] (userLiked) in
                guard let self = self else { return }
                
                self.likeCountLabel.textColor = userLiked == true ? .primaryColor : .gray2
                self.likeImageView.tintColor = userLiked == true ? .primaryColor : .gray2
            }
            .disposed(by: disposeBag)
        
        photoImageView.kf.setImage(with: viewModel.photoURL)
        avatarImageView.kf.setImage(with: viewModel.userAvatarURL)
        
        self.viewModel = viewModel
    }
    
    @objc func likeContainerDidTap(sender: UITapGestureRecognizer) {
        viewModel.likeButtonDidTap()
    }
}
