//
//  LoginApi.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import PSea
import Alamofire
class LoginApi: PetRequest {
    var successHandler: SccuessCallBack?
    
    var errorHandler: ErrorCallBack?
    
    var failureHandler: FailureCallBack?
    
    var username : String?
    var password : String?

    
    func needToken() -> Bool {
        return false
    }
    
    func petParameters() -> Parameters? {
        return ["username":username!,
                "password":password!]
    }
    
    func method() -> HTTPMethod {
        return .post
    }
    

    func requestURI() -> String {
        return "/petday/login"
    }
    

}
