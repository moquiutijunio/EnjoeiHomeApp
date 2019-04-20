//
//  ProductViewModel.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductViewModel: NSObject, ProductViewModelCallbackProtocol {
    
    let product: Product
    let title: String
    let details: String
    let userAvatarURL: URL?
    let photoURL: URL?
    var attributedText: NSMutableAttributedString?
    
    init(product: Product) {
        self.product = product
        self.title = product.title
        self.details = product.size != nil ? "R$ \(product.price) - tam \(product.size!)" : "R$ \(product.price)"
        self.userAvatarURL = product.user.image.imageId.convertToURLUsing(resolution: .mini)
        self.photoURL = product.images.first?.imageId.convertToURLUsing(resolution: .medium)
        self.likeCountRelay = BehaviorRelay(value: product.likesCount ?? 0)
        self.userLikedRelay = BehaviorRelay(value: false)
        
        super.init()
        
        let text = self.details
        attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
        if let size = product.size {
            let productSizeRange = (text as NSString).range(of: "- tam \(size)")
            attributedText?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray2, range: productSizeRange)
        }
    }
    
    private let likeCountRelay: BehaviorRelay<Int>
    var likeCount: Observable<String> {
        return likeCountRelay
            .asObservable()
            .map {"\($0)"}
    }
    
    private let userLikedRelay: BehaviorRelay<Bool>
    var userLiked: Observable<Bool> {
        return userLikedRelay
            .asObservable()
    }
    
    func likeButtonDidTap() {
        userLikedRelay.accept(!userLikedRelay.value)
        likeCountRelay.accept(userLikedRelay.value == true ? (likeCountRelay.value + 1) : (likeCountRelay.value - 1))
    }
}
