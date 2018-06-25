//
//  FindPasswordApi.swift
//  iOS-PetDay
//
//  Created by ke ma on 2018/3/8.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import UIKit
import PSea
import Alamofire

class ForgetPasswordApi: PetRequest {
    
    var successHandler: SccuessCallBack?
    
    var errorHandler: ErrorCallBack?
    
    var failureHandler: FailureCallBack?
    
    var username : String!
    var code : String!
    var password : String!
    
    
    func needToken() -> Bool {
        return false
    }
    
    func petParameters() -> Parameters? {
        return ["username":username,
                "code":code,
                "password":password]
    }
    
    func method() -> HTTPMethod {
        return .post
    }
    
    
    func requestURI() -> String {
        return "/petday/forgetpassword"
    }
}
