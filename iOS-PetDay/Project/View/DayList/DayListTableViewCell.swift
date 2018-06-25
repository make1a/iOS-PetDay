//
//  DayListTableViewCell.swift
//  iOS-PetDay
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

class DayListTableViewCell: UITableViewCell {
    static let identifier = "kDayListTableViewCellIdentifier"
    lazy var bannerLabel: UILabel = {
        var bannerLabel = UILabel()
        contentView.addSubview(bannerLabel)
        return bannerLabel
    }()
    
    

    static func dequeueReusable(WithTableView tableView:UITableView) -> DayListTableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: DayListTableViewCell.identifier)
        if  let cell = reusableCell {
            return cell as! DayListTableViewCell
        }else{
            let cell = DayListTableViewCell.init(style: .default, reuseIdentifier: DayListTableViewCell.identifier)
            return cell
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        snpLayoutSubview()
    }
    
    func updateDataSource(day:Day) {
        bannerLabel.text = "\(day.year)-\(day.month)-\(day.day)"
    }
    
    func snpLayoutSubview() {
        bannerLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
