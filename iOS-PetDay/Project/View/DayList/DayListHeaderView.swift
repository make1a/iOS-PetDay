//
//  DayListHeaderView.swift
//  iOS-PetDay
//
//  Created by Fidetro on 04/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

class DayListHeaderView: UITableViewHeaderFooterView {
    static let identifier = "kDayListHeaderViewIdentifier"
    
    lazy var bannerLabel: UILabel = {
        var bannerLabel = UILabel()
        contentView.addSubview(bannerLabel)
        return bannerLabel
    }()
    
    static func dequeueReusable(tableView:UITableView) -> DayListHeaderView {
       let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DayListHeaderView.identifier) as? DayListHeaderView
        

        
        guard let view = headerView else {
            return DayListHeaderView.init(reuseIdentifier: DayListHeaderView.identifier)
        }
        
        return view
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateDataSource(day:Day) {
        bannerLabel.text = "\(day.year)-\(day.month)-\(day.day)"
    }
    
    func snpLayoutSubview() {
        bannerLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }

}
