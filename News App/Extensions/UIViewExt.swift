//
//  UIViewExt.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func addBorder(borderWidth: CGFloat = 1, borderColor: CGColor = #colorLiteral(red: 0.1217509285, green: 0.576944828, blue: 0.08966673166, alpha: 1)) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
    
}
