//
//  ProductDetailsViewModel.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class ProductPriceViewModel: NSObject {

    private let product: Product
    let price: String
    var paymentDetails: String?
    var attributedText: NSMutableAttributedString?

    init(product: Product) {
        self.product = product
        self.price = "R$ \(product.price) R$ \(product.minimumPrice)"
        
        super.init()
        
        var paymentInformations = [String]()
        
        if product.discountPercentage != 0 {
            paymentInformations.append("\(product.discountPercentage)% off")
        }
        
        if product.maximumInstallment != 0 {
            paymentInformations.append(" até \(product.maximumInstallment)X")
        }
        
        paymentDetails = paymentInformations.joined(separator: " em ").uppercased()
        
        let text = self.price
        attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
        
        let range = (text as NSString).range(of: "R$ \(product.price)")
        attributedText?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.primaryColor, range: range)
        attributedText?.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
        let range2 = (text as NSString).range(of: "R$ \(product.minimumPrice)")
        attributedText?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range2)
        
        let range3 = (text as NSString).range(of: "\(product.price)")
        attributedText?.addAttribute(NSAttributedString.Key.font, value: UIFont.proximaNovaRegularBold(ofSize: 22)!, range: range3)
        
        let range4 = (text as NSString).range(of: "\(product.minimumPrice)")
        attributedText?.addAttribute(NSAttributedString.Key.font, value: UIFont.proximaNovaRegularBold(ofSize: 22)!, range: range4)
    }
}
