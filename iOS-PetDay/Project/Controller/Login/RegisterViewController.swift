//
//  RegisterViewController.swift
//  iOS-PetDay
//
//  Created by Fidetro on 05/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Arcane
import Alamofire
import SVProgressHUD

fileprivate extension Selector {
    static let registerAction = #selector(RegisterViewController.registerAction)
    static let codeAction = #selector(RegisterViewController.getRegisterCodeAction)
}

class RegisterViewController: UIViewController,CustomControllerProtocol {
    lazy var containerView: RegisterContainerView = {
        var containerView = RegisterContainerView()
        view.addSubview(containerView)
        containerView.registerButton.addTarget(self, action: .registerAction, for: .touchUpInside)
        containerView.codeView.checkCodeButton.addTarget(self, action: .codeAction, for: .touchUpInside)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        clearNavigationBar()
        snpLayoutSubview()
        setNavgationStyle()
    }
    
    func setNavgationStyle() {
        self.setTitle(MyLocalizedString("Register"))
    }
    
    
    // MARK:点击
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @objc func registerAction() {
        
        let reigsterApi = RegisterApi()
        reigsterApi.username = containerView.username!
        reigsterApi.code = containerView.code!
        reigsterApi.password = containerView.password!
        if reigsterApi.username.count != 11 {
            SVProgressHUD.showError(withStatus: "请输入正确的手机号")
            return
        }
        
        if reigsterApi.password.isEmpty {
            SVProgressHUD.showError(withStatus: "请输入密码")
            return
        }
        
        reigsterApi.request().success {  (_, value) in
            
            print("注册成功")
            
        }
    }
    
    @objc func getRegisterCodeAction(){
        
        print("获取验证码")

    }
    
    
    // MARK:布局
    func snpLayoutSubview() {
        containerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
}
