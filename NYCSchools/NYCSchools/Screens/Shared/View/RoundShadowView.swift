//
//  RoundShadowView.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import UIKit

class RoundShadowView: UIView {
    var cornerRadius: CGFloat = 0.0
    var shadowRadius: CGFloat = 0.0
      
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = shadowRadius
    }
}
