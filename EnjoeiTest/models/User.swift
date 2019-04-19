//
//  User.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

struct User: Codable {
    
    var image: Image
    
    enum CodingKeys: String, CodingKey {
        case image = "avatar"
    }
}
