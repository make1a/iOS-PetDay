//
//  FIDCameraHelper.swift
//  iOS-PetDay
//
//  Created by Fidetro on 09/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

enum CameraError:Error {
    case LaunchError(String)
}

class FIDCameraHelper: NSObject,
AVCaptureDepthDataOutputDelegate,
AVCaptureVideoDataOutputSampleBufferDelegate {
    static let shared = FIDCameraHelper()
    
    private override init() {}
    var cameraImage : UIImage?
    let motionManager = CMMotionManager()
    var orientation = UIImageOrientation.up
    let session = AVCaptureSession()
    
    static func startRunning() throws {
        try shared.setupAVCapture()
        shared.session.startRunning()
        weak var weakShared = shared
        self.startUpdateAccelerometer { (orientation) in
            weakShared?.orientation = orientation
        }
    }
    
    static func stopRunning() {
        shared.session.stopRunning()
        if shared.motionManager.isAccelerometerAvailable == true {
            shared.motionManager.stopAccelerometerUpdates()
        }
    }
    
    static func setCamera(bounds:CGRect) -> UIView {
        let view = UIView.init(frame: bounds)
        let preview = AVCaptureVideoPreviewLayer.init(session: shared.session)
        preview.frame = bounds
        preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(preview)
        return view
    }
    
   private static func startUpdateAccelerometer(result:((_ orientation:UIImageOrientation)->())? = nil) {
    guard shared.motionManager.isAccelerometerAvailable == true else { return  }
        guard let current = OperationQueue.current else { return  }
        shared.motionManager.accelerometerUpdateInterval = 0.1
        shared.motionManager.startAccelerometerUpdates(to: current) { (accelerometerData, error) in
            guard let x = accelerometerData?.acceleration.x else { return }
            guard let y = accelerometerData?.acceleration.y else { return }
            if fabs(y) >= fabs(x) {
                if y >= 0 {
                    if let block = result {
                        block(.down)
                    }
                }else{
                    if let block = result {
                        block(.up)
                    }
                }
            }else{
                if x >= 0 {
                    if let block = result {
                        block(.right)
                    }
                }else{
                    if let block = result {
                        block(.left)
                    }
                }
            }
        }
        
    }
    
    func setupAVCapture() throws {
        if UIDevice.current.userInterfaceIdiom == .phone {
            session.sessionPreset = .hd1920x1080
        }else{
            session.sessionPreset = .photo
        }
        guard let device = AVCaptureDevice.default(for: .video) else {
            throw CameraError.LaunchError("启动失败")
        }
        
        let deviceInput = try AVCaptureDeviceInput.init(device: device)
        if session.canAddInput(deviceInput) {
            session.addInput(deviceInput)
        }
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String:kCMPixelFormat_32BGRA]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        let queue = DispatchQueue.init(label: "VideoDataOutputQueue")
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
        }
    }
    
 
    private func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) throws {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
        let attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldNotPropagate) as?[String:Any] else {
            throw CameraError.LaunchError("启动失败")
        }
        let ciImage =  CIImage.init(cvPixelBuffer: pixelBuffer, options: attachments)
        switch orientation {
        case .up:
            connection.videoOrientation = .portrait
        case .down:
            connection.videoOrientation = .portraitUpsideDown
        case .left:
            connection.videoOrientation = .landscapeLeft
        case .right:
            connection.videoOrientation = .landscapeRight
        default:
            break
        }
        cameraImage = UIImage.init(ciImage: ciImage, scale: 1, orientation: orientation)
    }
    
}
