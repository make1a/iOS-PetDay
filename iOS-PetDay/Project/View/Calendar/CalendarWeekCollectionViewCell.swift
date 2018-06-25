//
//  CalendarWeekCollectionViewCell.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

class CalendarWeekCollectionViewCell: UICollectionViewCell {
    static let identifier = "kCalendarWeekCollectionViewCellIdentifier"
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .themeBlackColor()
        titleLabel.textColor = .white
        titleLabel.font = .themeFont(ofSize: 17)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        snpLayoutSubview()
    }
    
    
    static func dequeueReusable(withCollectionView collectionView:UICollectionView,for indexPath:IndexPath) -> CalendarWeekCollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CalendarWeekCollectionViewCell.identifier, for: indexPath) as! CalendarWeekCollectionViewCell
    }
    
    
  
    func updateWeek(row:Int) {
        let calendar = Calendar.current
        let text = calendar.shortWeekdaySymbols[row]
        titleLabel.text = text
    }
    
    
    func snpLayoutSubview() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
