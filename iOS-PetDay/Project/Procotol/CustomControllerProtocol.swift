//
//  CustomControllerProtocol.swift
//  Calendar
//
//  Created by Fidetro on 02/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

protocol CustomControllerProtocol  {
    func clearNavigationBar()
    func setNavigationBar(color:UIColor)
    func presentAlert(title:String?,
                      message:String?,
                      preferredStyle:UIAlertControllerStyle,
                      actions:[UIAlertAction])
}
extension CustomControllerProtocol where Self:UIViewController {
    func clearNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setNavigationBar(color:UIColor) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = color
    }
    
    func setTitle(_ title:String?, color:UIColor? = .black) {
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:color ?? .black]
    }
    func presentAlert(title:String?,
                      message:String?,
                      preferredStyle:UIAlertControllerStyle,
                      actions:[UIAlertAction]) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
        
        for i in actions { alertVC.addAction(i) }
        self.present(alertVC, animated: true, completion: nil)
    }
}

