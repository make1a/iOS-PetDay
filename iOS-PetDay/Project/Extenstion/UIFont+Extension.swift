//
//  UIFont+Extension.swift
//  Calendar
//
//  Created by Fidetro on 25/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

extension UIFont {
    static func themeFont(ofSize: CGFloat) -> UIFont {
        guard let font = UIFont.init(name: "PingFangSC-Regular", size: ofSize) else {
            return UIFont.systemFont(ofSize:ofSize)
        }
        return font
    }
}
