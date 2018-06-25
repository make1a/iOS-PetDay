//
//  Sign.swift
//  TestRequest
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Arcane
fileprivate extension String  {
    var md5: String {
        if let md5 = Hash.MD5(self) {
            return md5
        }
        return ""
    }
}

extension Dictionary {
    func sign() -> String{
//        return self.toString
        let sign = AES.encrypt(self.toString, key: "123")!
        return sign
    }
}


fileprivate extension Dictionary {
    var toString : String {
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            guard var jsonString = String.init(data: jsonData, encoding: .utf8) else {
                return ""
            }
            jsonString = jsonString.replacingOccurrences(of: " ", with: "")
            jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
            return jsonString
        }catch{
            print(error)
            return ""
        }
    }
}

