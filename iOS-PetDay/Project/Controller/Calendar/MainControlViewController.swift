//
//  MainControlViewController.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/04/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
fileprivate extension Selector {
    static let mainControlAction = #selector(MainControlViewController.mainControlAction(sender:))
}
class MainControlViewController: UIViewController {
    lazy var containerView: MainControlContainerView = {
        var containerView = MainControlContainerView()
        view.addSubview(containerView)
        containerView.controlButton.addTarget(self, action: .mainControlAction, for: .touchUpInside)
        return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        snpLayoutSubview()
    }
    
    @objc func mainControlAction(sender:UIButton) {
        dissAnimation()
    }
    

    
    func snpLayoutSubview() {
        containerView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        presentAnimation()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
// MARK: 动画
extension MainControlViewController {
    func presentAnimation() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            self.containerView.controlButton.makeRotation(repeatCount: 2, duration: 0.3, to: 2*Double.pi)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .overrideInheritedCurve, animations: {
                self.containerView.leftButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-90)
                }
                self.containerView.centerButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-110)
                }
                self.containerView.rightButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-90)
                }
                self.containerView.leftButton.alpha = 1
                self.containerView.centerButton.alpha = 1
                self.containerView.rightButton.alpha = 1
                self.containerView.effectView.alpha = 0.5
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        })
    }
    
    
    func dissAnimation() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            self.containerView.controlButton.makeRotation(repeatCount: 2, duration: 0.3, to: -2*Double.pi)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .overrideInheritedCurve, animations: {
                self.containerView.leftButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview()
                }
                self.containerView.centerButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-20)
                }
                self.containerView.rightButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview()
                }
                self.containerView.leftButton.alpha = 0
                self.containerView.centerButton.alpha = 0
                self.containerView.rightButton.alpha = 0
                self.containerView.effectView.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: {
                guard $0 == true else{
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        })
    }
}
