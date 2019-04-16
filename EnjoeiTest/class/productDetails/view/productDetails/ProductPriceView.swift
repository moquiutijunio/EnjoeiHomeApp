//
//  ProductPriceView.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class ProductPriceView: UIView {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var paymentDetailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        applyLayout()
    }

    private func applyLayout() {
        backgroundColor = .clear
        
        priceLabel.font = UIFont.proximaNovaRegularLight(ofSize: 22)
        priceLabel.textAlignment = .left
        
        paymentDetailsLabel.font = UIFont.proximaNovaRegularLight(ofSize: 14)
        paymentDetailsLabel.textAlignment = .left
        paymentDetailsLabel.textColor = UIColor(red: 0.49, green: 0.48, blue: 0.47, alpha: 1)
    }

    func bindIn(viewModel: ProductPriceViewModel) {

        priceLabel.text = viewModel.price
        paymentDetailsLabel.text = viewModel.paymentDetails
        priceLabel.attributedText = viewModel.attributedText
    }
}

extension ProductPriceView {
    
    class func instantiateFromNib() -> ProductPriceView {
        return Bundle.main.loadNibNamed("ProductPriceView", owner: self, options: nil)?.first as! ProductPriceView
    }
}
