//
//  DayListContainerView.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import SnapKit
class DayListContainerView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = .themeBlackColor()
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        self.addSubview(tableView)
        return tableView
    }()
    
    convenience init() {
        self.init(frame: .zero)
        snpLayoutSubview()
    }
    
    func snpLayoutSubview() {
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
}
