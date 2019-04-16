//
//  Font.swift
//  EnjoeiTest
//
//  Created by Junio Moquiuti on 16/04/19.
//  Copyright © 2019 Junio Moquiuti. All rights reserved.
//

import UIKit

extension UIFont {
    
    public static func proximaNovaRegularBold(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-Bold", size: ofSize)
    }
    
    public static func proximaNovaRegularLight(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-Light", size: ofSize)
    }
    
    public static func proximaNovaRegularLightItalic(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-LightItalic", size: ofSize)
    }
    
    public static func proximaNovaRegular(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-Regular", size: ofSize)
    }
    
    public static func proximaNovaSemibold(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-Semibold", size: ofSize)
    }
}
