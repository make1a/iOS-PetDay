//
//  CheckCodeView.swift
//  iOS-PetDay
//
//  Created by Fidetro on 08/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

class CheckCodeView: UIView,UITextFieldDelegate {

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
    
    lazy var textField: UITextField = {
        var textField = UITextField()
        textField.delegate = self
        self.addSubview(textField)
        
        return textField
    }()
    
    lazy var checkCodeButton: UIButton = {
        var checkCodeButton = UIButton()
        checkCodeButton.setTitleColor(.black, for: .normal)
        checkCodeButton.setTitle(MyLocalizedString("Send Code"), for: .normal)
        addSubview(checkCodeButton)
        return checkCodeButton
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
        checkCodeButton.snp.makeConstraints{
            $0.right.equalToSuperview().offset(-20)
//            $0.top.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalTo(textField.snp.right)
        }
        textField.snp.makeConstraints{
//            $0.left.equalToSuperview().offset(20)
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        checkCodeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        checkCodeButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
    }
    


}
