//
//  Image.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

struct Image: Codable {
    
    var imageId: String

    enum CodingKeys: String, CodingKey {
        case imageId = "image_public_id"
    }
}
