//
//  View.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 20/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

extension UIView {
    
    var toImage: UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}
