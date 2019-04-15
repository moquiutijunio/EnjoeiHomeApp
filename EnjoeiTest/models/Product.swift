//
//  Product.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//


struct Product {
    var title: String
    var images: [Image]
    var minimumPrice: Int
    var price: Int
    var userImage: Image
    var likesCount: Int?
    var size: String?
    
    init?(json: [String: Any]) {
        guard let title = json["seo_title"] as? String,
            let minimumPrice = json["minimum_price_integer"] as? Int,
            let price = json["original_price_integer"] as? Int,
            let userJson = json["user"] as? [String: Any],
            let userAvatarJson = userJson["avatar"] as? [String: Any],
            let userImage = Image(json: userAvatarJson),
            let imagesPathsJson = json["photos"] as? [[String: Any]] else {
                
                return nil
        }
        
        self.title = title
        self.minimumPrice = minimumPrice
        self.price = price
        self.userImage = userImage
        self.likesCount = json["likes_count"] as? Int ?? 0
        self.size = json["size"] as? String
        self.images = Image.mapArray(imagesPathsJson: imagesPathsJson)
    }
}
