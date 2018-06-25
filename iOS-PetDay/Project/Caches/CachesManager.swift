//
//  CachesManager.swift
//  iOS-PetDay
//
//  Created by Fidetro on 23/02/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import SwiftFFDB
class CachesManager: NSObject {
    static func updateUser(_ user:User) {
        guard let uid = user.uid else {
            return
        }
        //判断用户是否存在
        guard let primaryID = (User.select(where:"uid = ?",values:[uid]) as! [User]?)?.first?.primaryID else {
            user.insert()
            return
        }
        user.primaryID = primaryID
        user.update()
    }
    
    static func user() -> User? {
        return User.select(where: nil)?.first as! User?
    }
    
    func getToken() -> String?{
        let user = User.select(where: nil)?.first as! User?
        
        return user?.token
    }
}
