//
//  Timer+Extension.swift
//  iOS-PetDay
//
//  Created by Fidetro on 08/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
typealias TOperation = ()->()

fileprivate extension Selector {
    static let blockInvoke = #selector(Timer.blockInvoke(timer:))
}

extension Timer {
    private static var share = TimerOperation()
    private struct TimerOperation {
        
        var operations = Set<String>()
    }
    
    
    
    private static func shareRunLoop() -> RunLoop {
        Thread.current.name = "com.fidetro.eventRunLoop"
        let runLoop = RunLoop.current
        runLoop.add(NSMachPort(), forMode: .defaultRunLoopMode)
        return runLoop
    }
    
    
    /// timer block support
    @discardableResult static func bs_scheduledTimer(withTimeInterval interval:TimeInterval,
                                                     block:(_ timer:Timer)->(),
                                                     repeats:Bool) -> Timer {
        return self.scheduledTimer(timeInterval: interval, target: self, selector: .blockInvoke, userInfo: block, repeats: repeats)
    }
    
    
    
    static func add(operation:@escaping TOperation,
                    interval:TimeInterval,
                    tag:String) {
        
        guard share.operations.contains(tag) == false else {
            return
        }
            operation()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + interval, execute: {
            share.operations.remove(tag)
        })
        
//        let timer = Timer.bs_scheduledTimer(withTimeInterval: interval, block: { (timer) in
//            weak var weakTimer = timer
//
//            weakTimer?.invalidate()
//            weakTimer = nil
//        }, repeats: false)
        share.operations.insert(tag)
//        timer.fire()
//        shareRunLoop().add(timer, forMode: .defaultRunLoopMode)
    }
    
    
    @objc fileprivate static func blockInvoke(timer:Timer) {
        if let block = timer.userInfo as? (_ timer:Timer)->() {
            block(timer)
        }
    }
    
}
