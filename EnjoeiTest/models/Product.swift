//
//  Product.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

struct Product: Codable {

    var title: String
    var images: [Image]
    var minimumPrice: Int
    var price: Int
    var user: User
    var likesCount: Int?
    var size: String?
    var discountPercentage: Int
    var maximumInstallment: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "seo_title"
        case images = "photos"
        case minimumPrice = "minimum_price_integer"
        case price = "original_price_integer"
        case user = "user"
        case likesCount = "likes_count"
        case size = "size"
        case discountPercentage = "discount_percentage"
        case maximumInstallment = "maximum_installment"
    }
}
