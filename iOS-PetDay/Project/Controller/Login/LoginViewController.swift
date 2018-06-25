//
//  LoginViewController.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Arcane
import Alamofire
import SwiftyJSON
import SVProgressHUD
import SwiftFFDB

fileprivate extension Selector {
    static let loginAction = #selector(LoginViewController.loginAction(sender:))
    static let registerAction = #selector(LoginViewController.registerAction(sender:))
    static let forgetPwdAction = #selector(LoginViewController.pushToForgetPwdAction(sender:))
}

class LoginViewController: UIViewController,CustomControllerProtocol {
    
    let testView = UIView.init(frame: CGRect.init(x: 39, y: 39, width: 60, height: 60))
    
    lazy var containerView: LoginContainerView = {
        var containerView = LoginContainerView()
        
        ///test
        containerView.usernameView.textField.text = "13380397421"
        containerView.passwordView.textField.text = "123456"
        
        containerView.loginButton.addTarget(self, action: .loginAction, for: .touchUpInside)
        containerView.registerButton.addTarget(self, action: .registerAction, for: .touchUpInside)
        containerView.forgetPwdButton.addTarget(self, action: .forgetPwdAction, for: .touchUpInside)
        view.addSubview(containerView)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        clearNavigationBar()
        snpLayoutSubview()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

//        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
//        
//                let api = QNUploadTokenApi()
//                api.uid = "1"
//                api.putPolicy =
//                    ["scope": "pet-day",
//                     "deadline":Int(Date().timeIntervalSince1970+60*60)]
//        api.upload(image: UIImage.init(named: "icon_location")!)
    }
    
    
    //MARK: 登陆
    @objc func loginAction(sender:UIButton) {
        let login = LoginApi()
        
        login.username = containerView.usernameView.textField.text
        login.password = containerView.passwordView.textField.text
        
        if !((login.username?.isEmpty)!) && !((login.password?.isEmpty)!) {
            
            login.request().success { (_, value) in
                
                if JSON(value)["data"]["token"].string != nil {
                    let user = User()
                    user.token = JSON(value)["data"]["token"].string
                    user.uid = JSON(value)["data"]["uid"].int64
                    user.username = JSON(value)["data"]["username"].string
                    do{
                        try FFDBManager.delete(User.self, where: nil, values: nil, database: nil)
                        user.insert()
                        SVProgressHUD.showSuccess(withStatus: "登陆成功")
                        
                        self.present(BaseNavigationController.init(rootViewController: CalendarViewController()), animated: true, completion: nil)
                    }catch{
                        print(error)
                    }
                }
                print(value)
                
                }.failure { (_ response:DataResponse<Any>,_ error:Error?) in
                    
                    print("这里是failure")
                    SVProgressHUD.showError(withStatus: response.result.value as? String)
                    print(response.result.value)
                    
                }.error { (_, _, _) in
                    SVProgressHUD.showError(withStatus: "错误")
                    print("error")
            }
        }else{
            SVProgressHUD.showError(withStatus: "账号和密码不能为空")
        }
        
        
    }
    
    @objc func pushToForgetPwdAction(sender:UIButton){
        self.navigationController?.pushViewController(ForgetPwdViewController(), animated: true)
    }
    
    @objc func registerAction(sender:UIButton) {        
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    func snpLayoutSubview() {
        containerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
}

