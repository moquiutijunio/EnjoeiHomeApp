//
//  String.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 19/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import Foundation

enum ImageResolutions: String {
    case small = "180x180"
    case mini = "460x460"
    case medium = "800x800"
    case high = "1100xN"
}

extension String {
    
    func convertToURLUsing(resolution: ImageResolutions) -> URL? {
        return URL(string: "\(APIClient.photoBaseURLString)/\(resolution.rawValue)/\(self).jpg")
    }
}
