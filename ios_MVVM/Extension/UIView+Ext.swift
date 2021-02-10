//
//  UIView+Ext.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 04/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func dropShadow(){
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.2
        clipsToBounds = false
    }
    
    func shadowedView(_ view: UIView?, color: UIColor, offset: CGSize, radius: CGFloat, alpha: Float) {
      let shadowPath = UIBezierPath(roundedRect: view?.bounds ?? CGRect.zero,
                                    cornerRadius: radius)
      let shadowLayer = CAShapeLayer()
      shadowLayer.path = shadowPath.cgPath

      view?.layer.shadowColor = color.cgColor
      view?.layer.shadowOffset = offset
      view?.layer.shadowOpacity = alpha
      view?.layer.shadowPath = shadowPath.cgPath
      view?.layer.shadowRadius = CGFloat(radius)
      view?.layer.masksToBounds = false
    }
}
