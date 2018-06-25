//
//  RegisterApi.swift
//  iOS-PetDay
//
//  Created by Fidetro on 05/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Alamofire
import PSea
class RegisterApi: PetRequest {
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
        return "/petday/register"
    }
}
