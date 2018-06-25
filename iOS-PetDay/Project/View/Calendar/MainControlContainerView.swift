//
//  MainControlContainerView.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/04/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import SnapKit


class MainControlContainerView: UIView {
    lazy var controlButton: UIButton = {
        var controlButton = UIButton()
        addSubview(controlButton)
        controlButton.setBackgroundImage(UIImage.init(named: "icon_maincontrol"), for: .normal)
        controlButton.layer.cornerRadius = 30
        controlButton.layer.masksToBounds = true
        controlButton.adjustsImageWhenHighlighted = false
        return controlButton
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect.init(style: .extraLight)
        var effectView = UIVisualEffectView.init(effect: effect)
        effectView.alpha = 0
        addSubview(effectView)
        return effectView
    }()
    
    lazy var leftButton: UIButton = {
        var leftButton = UIButton()
        addSubview(leftButton)
        leftButton.setBackgroundImage(UIImage.init(named: "icon_maincontrol"), for: .normal)
        leftButton.layer.cornerRadius = 30
        leftButton.layer.masksToBounds = true
        leftButton.adjustsImageWhenHighlighted = false
        leftButton.alpha = 0
        return leftButton
    }()
    
    lazy var centerButton: UIButton = {
        var centerButton = UIButton()
        addSubview(centerButton)
        centerButton.setBackgroundImage(UIImage.init(named: "icon_maincontrol"), for: .normal)
        centerButton.layer.cornerRadius = 30
        centerButton.layer.masksToBounds = true
        centerButton.adjustsImageWhenHighlighted = false
        centerButton.alpha = 0
        return centerButton
    }()
    
    lazy var rightButton: UIButton = {
        var rightButton = UIButton()
        addSubview(rightButton)
        rightButton.setBackgroundImage(UIImage.init(named: "icon_maincontrol"), for: .normal)
        rightButton.layer.cornerRadius = 30
        rightButton.layer.masksToBounds = true
        rightButton.adjustsImageWhenHighlighted = false
        rightButton.alpha = 0
        return rightButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    func snpLayoutSubview() {
        
        effectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        controlButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.height.equalTo(60)
        }
        leftButton.snp.makeConstraints {
            $0.right.equalTo(controlButton.snp.left).offset(-40)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        centerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.height.equalTo(60)
        }
        rightButton.snp.makeConstraints {
            $0.left.equalTo(controlButton.snp.right).offset(40)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(60)
        }
    }
    
}
