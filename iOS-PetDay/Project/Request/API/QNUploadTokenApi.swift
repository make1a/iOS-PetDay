//
//  QNUploadTokenApi.swift
//  iOS-PetDay
//
//  Created by Fidetro on 29/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import PSea
import Alamofire
class QNUploadTokenApi: PetRequest {

    
    var putPolicy = [String:Any]()
    var uid = String()
    func needToken() -> Bool {
        return true
    }
    
    func requestURI() -> String {
        return "/petday/qnuploadtoken"
    }
    
    func petParameters() -> Parameters? {
        return ["putPolicy":putPolicy,
                "uid":uid]
    }
    
    var successHandler: SccuessCallBack?
    
    var errorHandler: ErrorCallBack?
    
    var failureHandler: FailureCallBack?
    
    func method() -> HTTPMethod {
        return .post
    }
    
    func upload(image:UIImage) -> () {
        request().success { (response, parameters) in
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(UIImageJPEGRepresentation(image, 1)!, withName: "file", fileName: "IMG_2622", mimeType: "image/jpeg")
                guard let param = (parameters as! [String:Any])["data"] else{ return }
                print(param)
                guard let data = param as? [String:String] else{ return }
                for (key, value) in data {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to:"https://upload-z2.qiniup.com")
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        //print(progress)
                    })
                    
                    upload.responseJSON { re in
                        //这里会返回成功的结果
                        print (re.result.value)
                    }
                    
                case .failure(let encodingError):
                    print (encodingError)
                }
            }
            
        }
    }
    

}
