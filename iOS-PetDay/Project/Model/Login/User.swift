//
//  User.swift
//  iOS-PetDay
//
//  Created by Fidetro on 23/02/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import SwiftFFDB

class User: FFObject {
    
    var primaryID: Int64?
    var username : String?
    var nickname : String?    
    var uid : Int64?
    var token : String?
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
    

    required init() {
        
}
}
