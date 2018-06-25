//
//  UINavigationItem+Extension.swift
//  Calendar
//
//  Created by Fidetro on 26/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit
enum NavigationItemsOrientation {
    case left
    case right
}

extension UINavigationItem {
    convenience  init(_ left:[Any]?,center _:Any? = nil,_ right:[Any]?) {
        self.init()
        if let items = left {
            setupNavigationItem(items: items, orientation: .left)
        }
        if let items = right {
            setupNavigationItem(items: items, orientation: .right)
        }
    }
    func setupNavigationItem(items:[Any],
                             orientation:NavigationItemsOrientation,
                             actions:[Selector?]? = nil,
                             target:AnyObject? = nil) {
        var buttonItems = [UIBarButtonItem]()
        for (index,element) in items.enumerated() {
            let action = actions?[index]
            let button = initBaseButton()
            
            if let selector = action {
                if element is UIButton {
                    (element as! UIButton).addTarget(target, action: selector, for: .touchUpInside)
                    let item = UIBarButtonItem.init(customView: element as! UIButton)
                    buttonItems.append(item)
                }else{
                    button.addTarget(target, action: selector, for: .touchUpInside)
                }
            }
            switch element {
            case let element as UIImage:                
                button.setImage(element, for: .normal)
                button.sizeToFit()
                let item = UIBarButtonItem.init(customView: button)
                buttonItems.append(item)
            case let element as String:
                button.setTitle(element, for: .normal)
                button.sizeToFit()
                let item = UIBarButtonItem.init(customView: button)
                buttonItems.append(item)
            case  let element as UIBarButtonItem:
                element.action = action
                element.target = target
                buttonItems.append(element)
            case  let element as Int:
                let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                spaceItem.width = CGFloat(element)
                buttonItems.append(spaceItem)
            case  let element as Float:
                let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                spaceItem.width = CGFloat(element)
                buttonItems.append(spaceItem)
            case  let element as CGFloat:
                let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                spaceItem.width = CGFloat(element)
                buttonItems.append(spaceItem)
            case  let element as Double:
                let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                spaceItem.width = CGFloat(element)
                buttonItems.append(spaceItem)
            default: break
              
            }
        }
        if orientation == .left {
            self.leftBarButtonItems = buttonItems
        }else{
            self.rightBarButtonItems = buttonItems
        }
        
    }
    private func initBaseButton() -> UIButton {
        let button = UIButton.init(type: .custom)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
}
