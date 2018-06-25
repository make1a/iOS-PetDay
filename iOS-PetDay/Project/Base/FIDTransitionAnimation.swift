//
//  FIDTransitionAnimation.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

enum TransitioningOperation{
    case push
    case pop
}

class FIDAlphaAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    
    var operation : TransitioningOperation
    

     init(operation:TransitioningOperation) {
        self.operation = operation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
     func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        if operation == .push {
            fromVC.view.alpha = 1
            toVC.view.alpha = 0
            containerView.sendSubview(toBack: toVC.view)
        }else{
            fromVC.view.alpha = 1
            toVC.view.alpha = 0
        }
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            if self.operation == .push {
                fromVC.view.alpha = 0
                toVC.view.alpha = 1
            }else{
                fromVC.view.alpha = 0
                toVC.view.alpha = 1
            }
            
        }) { (_) in
            if self.operation == .push {
            transitionContext.completeTransition(true)
            }else{
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
    }
}

class FIDLargeAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)!
        toVC.view.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            toVC.view.transform = .identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}

class FIDSmallAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!

        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.sendSubview(toBack: toVC.view)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromVC.view.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

