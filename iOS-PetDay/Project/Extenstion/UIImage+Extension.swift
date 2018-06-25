//
//  UIImage+Extension.swift
//  iOS-PetDay
//
//  Created by Fidetro on 04/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

extension UIImage {
   static func create(color:UIColor,rect:CGRect) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage!
    }
}
