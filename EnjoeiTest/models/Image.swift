//
//  Image.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import Foundation

struct Image {
    var imageURL: URL
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    init?(json: [String: Any]) {
        guard let imagePathString = json["image_public_id"] as? String,
            let imageURL = URL(string: "\(APIClientHost.photoBaseURLString)/800x800/\(imagePathString).jpg") else {
                return nil
        }
        
        self.imageURL = imageURL
    }
    
    static func mapArray(imagesPathsJson: [[String: Any]]) -> [Image] {
        var images = [Image]()
        
        for json in imagesPathsJson {
            if let image = Image(json: json) {
                images.append(image)
            }
        }
        
        return images
    }
}
