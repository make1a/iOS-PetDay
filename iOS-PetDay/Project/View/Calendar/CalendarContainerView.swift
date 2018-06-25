//
//  CalendarContainerView.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

protocol CalendarContainerViewProtocol:class {
    func localNeedUpdate(sender:UIButton)
    func clickPhotoAction(sender:UIButton,countLabel:UILabel)
    func clickMainControlAction(sender:UIButton)
}

fileprivate extension Selector {
    static let mainControlAction = #selector(CalendarContainerView.mainControlAction(sender:))
}


class CalendarContainerView:UIView {
    
    weak var delegate : CalendarContainerViewProtocol?
    /// 日期
    var days = [Int]()
    /// 记录点击的section
    var selectedIndexPath = IndexPath.init(row: 0, section: 0)
    
    var clickQuick_block : ((_ row : Int)->())? = nil
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    lazy var controlButton: UIButton = {
        var controlButton = UIButton()
        addSubview(controlButton)
        controlButton.setBackgroundImage(UIImage.init(named: "icon_maincontrol"), for: .normal)
        controlButton.layer.cornerRadius = 30
        controlButton.layer.masksToBounds = true
//        controlButton.adjustsImageWhenHighlighted = false
        controlButton.addTarget(self, action: .mainControlAction, for: .touchUpInside)
        return controlButton
    }()
    
    lazy var collectionView: UICollectionView = {
        
      
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout:flowLayout)
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.themeBackgroundColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EmptyCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                withReuseIdentifier: EmptyCollectionReusableView.identifier)
        collectionView.register(QuickUploadCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                withReuseIdentifier: QuickUploadCollectionReusableView.identifier)
        collectionView.register(CalendarIntroductionCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarIntroductionCollectionViewCell.identifier)
        collectionView.register(CalendarWeekCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarWeekCollectionViewCell.identifier)
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshEvent() {
        days = [Int]()
        let emptyCount = DateHelper.shared.firstDayForCurrentMonth.weekDay() - 1
        for _ in 0..<emptyCount {
            days.append(0)
        }
        for i in 0..<DateHelper.shared.firstDayForCurrentMonth.MaxDayOfMonth() {
                days.append(i+1)
        }
        collectionView.reloadData()
    }

    @objc func mainControlAction(sender:UIButton) {
        self.delegate?.clickMainControlAction(sender: sender)
    }

    
    
    
    /// collectionView之间的间隔
    ///
    /// - Returns: 间隔距离
    func space() -> CGFloat {
        return 1
    }
    
    func snpLayoutSubview() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        controlButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.height.equalTo(60)
        }

    }
    
}

extension CalendarContainerView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 + days.count/7 + (days.count%7 == 0 ?  0:1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let lastSection = days.count/7 + (days.count%7 == 0 ?  0:1)
        guard section == lastSection else {
            return 7
        }
        
        return days.count % 7 == 0 ? 7 : days.count % 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = CalendarWeekCollectionViewCell
                .dequeueReusable(withCollectionView: collectionView, for: indexPath)
            cell.updateWeek(row:indexPath.row)
            
            return cell
        default:
            let cell = CalendarIntroductionCollectionViewCell
                .dequeueReusable(withCollectionView: collectionView, for: indexPath)
            cell.updateDay(days[(indexPath.section-1)*7+indexPath.row])
            
            if selectedIndexPath.row == indexPath.row,selectedIndexPath.section == indexPath.section {
                cell.draw()
            }else{
                cell.removeLayer()
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            return EmptyCollectionReusableView.dequeueReusable(withCollectionView: collectionView, for: indexPath)
        }
        let quickView = QuickUploadCollectionReusableView.dequeueReusable(withCollectionView: collectionView, for: indexPath)
        quickView.updateLocation_block = { (sender) in
            self.delegate?.localNeedUpdate(sender: sender)
        }
        quickView.selectPhoto_block = { (sender,label) in
            self.delegate?.clickPhotoAction(sender: sender,countLabel:label)
        }
        return quickView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard days[(indexPath.section-1)*7+indexPath.row] != 0 else {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as? CalendarIntroductionCollectionViewCell
        let lastCell = collectionView.cellForItem(at: self.selectedIndexPath) as? CalendarIntroductionCollectionViewCell
        UIView.animate(withDuration: 0.3) {
            collectionView.performBatchUpdates({
                self.selectedIndexPath.section = self.selectedIndexPath.section == indexPath.section ? 0 : indexPath.section
                self.selectedIndexPath.row = indexPath.row
                cell?.draw()
                lastCell?.removeAnimationLayer()
                
            }, completion: { (_) in
                
                collectionView.reloadData()
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/7-space()
        if indexPath.section != 0 {
            
        }
        return CGSize.init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize.init(width: collectionView.bounds.width, height: CGFloat.leastNormalMagnitude)
        }
        
        let detailHeight = QuickUploadCollectionReusableView.height()
        return selectedIndexPath.section == section ? CGSize.init(width: collectionView.bounds.width, height: detailHeight):CGSize.init(width: collectionView.bounds.width, height: CGFloat.leastNormalMagnitude)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
