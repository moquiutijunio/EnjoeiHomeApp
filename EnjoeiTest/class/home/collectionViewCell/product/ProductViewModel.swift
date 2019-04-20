//
//  ProductViewModel.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class ProductViewModel: NSObject {
    
    let product: Product
    let title: String
    let details: String
    let likeCount: String
    let userAvatarURL: URL?
    let photoURL: URL?
    var attributedText: NSMutableAttributedString?
    
    init(product: Product) {
        self.product = product
        self.title = product.title
        self.details = product.size != nil ? "R$ \(product.price) - tam \(product.size!)" : "R$ \(product.price)"
        self.likeCount = "\(product.likesCount ?? 0)"
        self.userAvatarURL = product.user.image.imageId.convertToURLUsing(resolution: .mini)
        self.photoURL = product.images.first?.imageId.convertToURLUsing(resolution: .medium)
        
        super.init()
        
        let text = self.details
        attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
        if let size = product.size {
            let productSizeRange = (text as NSString).range(of: "- tam \(size)")
            attributedText?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray2, range: productSizeRange)
        }
    }
}
