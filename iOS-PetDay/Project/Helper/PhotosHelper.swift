//
//  PhotosHelper.swift
//  iOS-PetDay
//
//  Created by Fidetro on 09/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import Photos
class PhotosHelper: NSObject {
    static func requestPhoto(authorizationStatus:((_ result:Bool)->())? = nil) {
        PHPhotoLibrary.requestAuthorization { (status) in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized :
                    if let block = authorizationStatus {
                        block(true)
                    }
                default :
                    if let block = authorizationStatus {
                        block(false)
                    }
                }
            }
        }
    }
    static func requestVideo(authorizationStatus:((_ result:Bool)->())? = nil) {
        AVCaptureDevice.requestAccess(for: .video) { (result) in
            if let block = authorizationStatus {
                block(result)
            }
        }
    }
    
    static func allCollection() {
        PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
    }
    
}
