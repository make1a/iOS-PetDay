//
//  InputView.swift
//  iOS-PetDay
//
//  Created by Fidetro on 05/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
class InputView: UIView,UITextFieldDelegate {
    
    
    lazy var shapeLayer : CAShapeLayer = {
        var shapeLayer = CAShapeLayer()
         shapeLayer.frame = self.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: textField.frame.origin.x, y: textField.bounds.size.height))
        path.addLine(to: CGPoint.init(x: textField.bounds.size.width, y: textField.bounds.size.height))
        shapeLayer.path = path.cgPath
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }()
    var isDraw : Bool
    var beginEdit_block : (()->())? = nil
    var endEdit_block : (()->())? = nil
    lazy var textField: UITextField = {
        var textField = UITextField()
        textField.delegate = self
        self.addSubview(textField)
        
        return textField
    }()

    override init(frame: CGRect) {
        isDraw = false
        super.init(frame: frame)
    }
    
    convenience init() {
        
        self.init(frame: .zero)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("begin")
        guard isDraw == false else {
            return true
        }
        isDraw = true
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = 0
        animation.duration = 1
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.add(animation, forKey: nil)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("end")
        return true
    }
    
    
 
    
    
    func snpLayoutSubview() {
        textField.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        
        

    }
    
}
