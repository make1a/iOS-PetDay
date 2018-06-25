//
//  AppDelegate.swift
//  Calendar
//
//  Created by Fidetro on 20/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit
import Arcane

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AMapServices.shared().apiKey = "a3a39ccb6e0ed859b423d13bf4333a73"
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavigationController.init(rootViewController: CalendarViewController())
//        window?.rootViewController = BaseNavigationController.init(rootViewController: LoginViewController())
        window?.makeKeyAndVisible()

//        setRootController()
        
        User.registerTable() //大佬说要先注册才能insert
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate{
    
    func isLogin() -> Bool {
        let user = User.select(where: nil, values: nil)?.first as? User
        if user != nil {
            return true
        }
        return false
    }
    
    func setRootController() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        if isLogin() {
            window?.rootViewController = BaseNavigationController.init(rootViewController: CalendarViewController())
        }else{
            window?.rootViewController = BaseNavigationController.init(rootViewController: LoginViewController())
        }
        window?.makeKeyAndVisible()
    }
}
