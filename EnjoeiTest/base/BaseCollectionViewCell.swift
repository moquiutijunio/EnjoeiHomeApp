//
//  BaseCollectionViewCell.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 15/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    static var nibName: String {
        return String(describing: self)
    }
}
