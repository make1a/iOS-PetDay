//
//  PetRequest.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import PSea
import Alamofire
import SVProgressHUD
public typealias Parameters = [String: Any]


public protocol PetRequest : PSea {
    
    /// 是否需要token
    func needToken() -> Bool
    /// 请求参数
    func petParameters() -> Parameters?
}

extension PetRequest {
    public func headers() -> HTTPHeaders? {
        return ["Content-type":"application/json",
                "Accept":"application/json"]
    }

    func baseURL() -> String {  
//        return "http://120.77.168.124:23333"
        return "http://127.0.0.1:23333"
    }
    public func parameters() -> Parameters? {
        
        var params = [String:Any]()
        if needToken() {
            params["token"] = "4857ba66e2fc38e3b72093f3d5aadb63"
        }
        guard var petParams = petParameters() else {
            return params
        }
        petParams["local-time"] = Date().timeIntervalSince1970
        print(petParams)
        let sign = petParams.sign()
        params["sign"] = sign
        
        
        return params
    }
    
    public func encoding() -> ParameterEncoding {
        if method() == .get {
            return URLEncoding(destination: .methodDependent)
        }else{
            return JSONEncoding.default
        }
    }
    
    
    func successParse(response:DataResponse<Any>){
        guard let value = response.result.value as? [String:Any],
            let _ = value["errcode"] as? Int else{
                return
        }
        if let handler = self.successHandler {
            handler(response,value)
        }else{
            //成功不处理
        }
    }
    func errorParse(response:DataResponse<Any>){
        guard let value = response.result.value as? [String:Any],
            let code = value["errcode"] as? Int else{
                return
        }
        let errmsg = value["errmsg"] as? String
        guard code == 0 else {
            if let handler = self.errorHandler {
                handler(response,code,errmsg ?? "")
            }else{
                SVProgressHUD.showError(withStatus: errmsg ?? "")
            }
            return
        }
    }
    
    func failureParse(response: DataResponse<Any>, error: Error) {
        guard let _ = response.result.value as? [String:Any] else{
            if let handler = self.failureHandler {
                handler(response,error)
            }else{
                //TODO: 提示请求超时
                SVProgressHUD.showError(withStatus: "网络连接超时")
            }
            return
        }
    }

}
