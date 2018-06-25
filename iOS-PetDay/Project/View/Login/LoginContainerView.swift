//
//  LoginContainerView.swift
//  iOS-PetDay
//
//  Created by Fidetro on 05/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

class LoginContainerView: UIView {
    
    lazy var bgImageView: UIImageView = {
       var imageView = UIImageView.init()
        imageView.image = #imageLiteral(resourceName: "login_bg")
        addSubview(imageView)
        return imageView
    }()
    
    lazy var headLabel: UILabel = {
       var label = UILabel()
        label.text = MyLocalizedString("登录")
        label.font = UIFont.boldSystemFont(ofSize: 32)
        addSubview(label)
        return label
    }()
    
    lazy var usernameTitleLabel: UILabel = {
        var usernameTitleLabel = UILabel()
        addSubview(usernameTitleLabel)
        usernameTitleLabel.font = .themeFont(ofSize: 24)
        usernameTitleLabel.text = MyLocalizedString("Username")
        return usernameTitleLabel
    }()
    
    lazy var passwordTitleLabel: UILabel = {
        var passwordTitleLabel = UILabel()
        addSubview(passwordTitleLabel)
        passwordTitleLabel.font = .themeFont(ofSize: 24)
        passwordTitleLabel.text = MyLocalizedString("Password")
        return passwordTitleLabel
    }()
    
    lazy var usernameView: InputView = {
        var usernameView = InputView()
        addSubview(usernameView)
        usernameView.textField.placeholder = "username"
        return usernameView
    }()
    
    lazy var passwordView: InputView = {
        var passwordView = InputView()
        addSubview(passwordView)
        passwordView.textField.placeholder = "password"
        return passwordView
    }()
    
    lazy var registerButton:UIButton = {
        var button = UIButton(type: UIButtonType.custom)
        addSubview(button)
        button.setTitle("立即注册", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var forgetPwdButton:UIButton = {
        var button = UIButton(type: .custom)
        addSubview(button)
        button.setTitle("找回密码", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        var loginButton = UIButton()
        loginButton.setTitle("登录", for: .normal)
        addSubview(loginButton)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 24
        loginButton.backgroundColor = UIColor.init(red: 1.0, green: 145/255.0, blue: 126/255.0, alpha: 1.0)
        return loginButton
    }()

     convenience init() {
        self.init(frame: .zero)
        snpLayoutSubview()
    }
    
    func snpLayoutSubview() {
        
        bgImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        headLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(30)
        }
        
        usernameTitleLabel.snp.makeConstraints{
            $0.top.equalTo(headLabel.snp.bottom).offset(50)
            $0.left.equalTo(headLabel.snp.left)
            $0.right.equalToSuperview().offset(-130)
        }
        usernameView.snp.makeConstraints{
            $0.top.equalTo(usernameTitleLabel.snp.bottom)
            $0.left.right.equalTo(usernameTitleLabel)
            $0.height.equalTo(30)
        }
        passwordTitleLabel.snp.makeConstraints{
            $0.top.equalTo(usernameView.snp.bottom).offset(20)
            $0.left.right.equalTo(usernameTitleLabel)
        }
        passwordView.snp.makeConstraints{
            $0.top.equalTo(passwordTitleLabel.snp.bottom)
            $0.left.right.equalTo(usernameTitleLabel)
            $0.height.equalTo(30)
        }
        loginButton.snp.makeConstraints{
            $0.top.equalTo(passwordView.snp.bottom).offset(20)
            $0.left.equalTo(usernameTitleLabel)
            $0.height.width.equalTo(48)
        }
        
        registerButton.snp.makeConstraints {
            $0.bottom.equalTo(forgetPwdButton.snp.top).offset(-10)
            $0.left.equalTo(usernameTitleLabel)
        }
        
        forgetPwdButton.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            } else {
                $0.bottom.equalTo(self.snp.bottom).offset(-20)
            }
            $0.left.equalTo(usernameTitleLabel)
        }
    }

}
