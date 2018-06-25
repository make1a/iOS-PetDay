//
//  UIView+Extension.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/04/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    func makeRotation(repeatCount:Float,
                      duration:TimeInterval,
                      from fromValue:Double?=nil,
                      to toValue:Double) {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.fromValue = NSNumber.init(value: fromValue ?? 0)
        animation.toValue = NSNumber.init(value: toValue)
        animation.duration = duration
        animation.autoreverses = false
        animation.repeatCount = repeatCount
        self.layer.add(animation, forKey: nil)
    }
    
}
