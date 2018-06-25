//
//  ForgetPwdViewController.swift
//  iOS-PetDay
//
//  Created by ke ma on 2018/3/8.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import UIKit
import SVProgressHUD

fileprivate extension Selector {
    static let findPasswordAction = #selector(ForgetPwdViewController.findPwdAction)
    static let codeAction = #selector(ForgetPwdViewController.getRegisterCodeAction)
}

class ForgetPwdViewController: UIViewController,CustomControllerProtocol {

    lazy var containerView: ForgetPwdContainerView = {
        var containerView = ForgetPwdContainerView()
        view.addSubview(containerView)
        containerView.registerButton.addTarget(self, action: .findPasswordAction, for: .touchUpInside)
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
        self.setTitle(MyLocalizedString("找回密码"))
    }

    // MARK:点击
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @objc func getRegisterCodeAction(){
        
        print("获取验证码")
    }

    @objc func findPwdAction() {
        
        let forgetPasswordApi = ForgetPasswordApi()
        forgetPasswordApi.username = containerView.username!
        forgetPasswordApi.code = containerView.code!
        forgetPasswordApi.password = containerView.password!
        
        if forgetPasswordApi.username.count != 11 {
            SVProgressHUD.showError(withStatus: "请输入正确的手机号")
            return
        }
        
        if forgetPasswordApi.password.isEmpty {
            SVProgressHUD.showError(withStatus: "请输入密码")
            return
        }
        
        forgetPasswordApi.request().success {  (_, value) in
            SVProgressHUD.showSuccess(withStatus: "修改成功")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK:布局
    func snpLayoutSubview() {
        containerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
