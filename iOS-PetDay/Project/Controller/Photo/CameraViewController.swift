//
//  CameraViewController.swift
//  iOS-PetDay
//
//  Created by Fidetro on 09/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,CustomControllerProtocol {

    deinit {
        print("释放")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationStyle()
        clearNavigationBar()
        view.addSubview(FIDCameraHelper.setCamera(bounds: view.bounds))
        try! FIDCameraHelper.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        FIDCameraHelper.stopRunning()
    }
    
    
    
    func setNavigationStyle() {
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
