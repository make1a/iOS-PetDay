//
//  DateSelectView.swift
//  Calendar
//
//  Created by Fidetro on 27/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

class DateSelectView: UIView {
    lazy var leftButton: UIButton = {
        let leftButton = UIButton.init(type: .custom)
        leftButton.setImage(UIImage.init(named: "nav_left"), for: .normal)
        addSubview(leftButton)
        return leftButton
    }()
    
    lazy var rightButton: UIButton = {
        let rightButton = UIButton.init(type: .custom)
        rightButton.setImage(UIImage.init(named: "nav_right"), for: .normal)
        addSubview(rightButton)
        return rightButton
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        addSubview(dateLabel)
        dateLabel.textColor = .white
        return dateLabel
    }()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        snpLayoutSubivew()
    }
    

    
    func snpLayoutSubivew() {
        dateLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        leftButton.snp.makeConstraints{
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
        rightButton.snp.makeConstraints{
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
    }

}
