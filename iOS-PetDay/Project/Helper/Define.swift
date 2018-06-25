//
//  Define.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

public func MyLocalizedString(_ key:String) -> String {
    return NSLocalizedString(key, comment: key)
}
public func navigationHeight() -> CGFloat {
    if #available(iOS 11.0, *) {
        if let top = UIApplication.shared.keyWindow?.safeAreaInsets.top,top > CGFloat.init(0) {
            return 88
        }
    } else {
        // Fallback on earlier versions
    }
    return 64
}



extension UIColor {
    static func themeBackgroundColor() -> UIColor {
        return UIColor.init(rgb: 0xf88542)
    }
    
    static func themeBlackColor() -> UIColor {
        return UIColor.init(rgb: 0xf88542)
    }
    static func placeholderColor() -> UIColor {
        return UIColor.init(rgb: 0xD8D8D8)
    }
}

extension CGFloat {
    static func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    static func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
