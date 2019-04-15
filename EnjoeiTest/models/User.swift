//
//  User.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

struct User {
    var image: Image
    
    init?(json: [String: Any]) {
        guard let imageJson = json["avatar"] as? [String: Any],
            let image = Image(json: imageJson) else {
                return nil
        }
        
        self.image = image
    }
}
