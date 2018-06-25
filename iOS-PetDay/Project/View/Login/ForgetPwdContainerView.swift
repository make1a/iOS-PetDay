//
//  ForgetPwdContainerView.swift
//  iOS-PetDay
//
//  Created by ke ma on 2018/3/8.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import UIKit

class ForgetPwdContainerView: UIView {

    var username : String? {
        return usernameView.textField.text
    }
    var code : String? {
        return codeView.textField.text
    }
    var password : String? {
        return passwordView.textField.text
    }
    
    lazy var usernameView: InputView = {
        var usernameView = InputView()
        addSubview(usernameView)
        usernameView.textField.placeholder = "username"
        return usernameView
    }()
    
    lazy var codeView: CheckCodeView = {
        var codeView = CheckCodeView()
        addSubview(codeView)
        codeView.textField.placeholder = "code"
        codeView.checkCodeButton.layer.masksToBounds = true
        codeView.checkCodeButton.layer.cornerRadius = 15
        return codeView
    }()
    
    lazy var passwordView: InputView = {
        var passwordView = InputView()
        addSubview(passwordView)
        passwordView.textField.placeholder = "password"
        return passwordView
    }()
    
    lazy var registerButton: UIButton = {
        var registerButton = UIButton()
        registerButton.setTitle(MyLocalizedString("Find password"), for: .normal)
        registerButton.backgroundColor = .black
        addSubview(registerButton)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = 24
        return registerButton
    }()
    
    convenience init() {
        self.init(frame: .zero)
        snpLayoutSubview()
    }
    
    func snpLayoutSubview() {
        usernameView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        codeView.snp.makeConstraints{
            $0.top.equalTo(usernameView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        passwordView.snp.makeConstraints{
            $0.top.equalTo(codeView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        registerButton.snp.makeConstraints{
            $0.top.equalTo(passwordView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }
    }

}
