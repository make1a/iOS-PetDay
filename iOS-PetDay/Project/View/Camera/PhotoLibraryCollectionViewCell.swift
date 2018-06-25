//
//  PhotoLibraryCollectionViewCell.swift
//  iOS-PetDay
//
//  Created by Fidetro on 09/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let onButtonClick = #selector(PhotoLibraryCollectionViewCell.selectionItemAction(sender:))
}

class PhotoLibraryCollectionViewCell: UICollectionViewCell {
    static let identifier = "kPhotoLibraryCollectionViewCellIdentifier"
    
    private let slectionIconWidth: CGFloat = 25
    //照片的标识
    var representAssetIdentifier: String!
    
    var handleSelectionAction: ((Bool) -> Void)?
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var selectionIcon: UIButton = {
        var selectionIcon = UIButton()
        selectionIcon = UIButton(frame: CGRect(x: 0, y: 0, width: slectionIconWidth, height: slectionIconWidth))
        selectionIcon.center = CGPoint(x: bounds.width - 2 - selectionIcon.bounds.width / 2, y: selectionIcon.bounds.height / 2)
        selectionIcon.setImage(#imageLiteral(resourceName: "iw_unselected"), for: .normal)
        selectionIcon.setImage(#imageLiteral(resourceName: "iw_selected"), for: .selected)
        
        return selectionIcon
    }()
    
    
    lazy var selectedButton:UIButton = {
        var selectedButton = UIButton(frame: CGRect(x: 0, y: 0, width: bounds.width * 2 / 5, height: bounds.width * 2 / 5))
        selectedButton.center = CGPoint(x: bounds.width - selectedButton.bounds.width / 2, y: selectedButton.bounds.width / 2)
        selectedButton.backgroundColor = .clear
        
        selectedButton.addTarget(self, action: .onButtonClick, for: .touchUpInside)
        return selectedButton
    }()
    
    var cellIsSelected: Bool = false {
        willSet {
            selectionIcon.isSelected = newValue
        }
    }
    
    /// 隐藏选择按钮和图标
    func hiddenIcons() {
        selectionIcon.isHidden = true
        selectedButton.isHidden = true
    }
    
    
    
    //MARK:点击
    @objc func selectionItemAction(sender:UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected {selectAnimation()}
        handleSelectionAction?(sender.isSelected)
    }


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        snpLayoutSubview()
    }
    
    
    static func dequeueReusable(withCollectionView collectionView:UICollectionView,for indexPath:IndexPath) -> PhotoLibraryCollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PhotoLibraryCollectionViewCell.identifier, for: indexPath) as! PhotoLibraryCollectionViewCell
    }

    func snpLayoutSubview() {
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(selectionIcon)
        contentView.addSubview(selectedButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:动画
    private func selectAnimation(){
        UIView.animate(withDuration: 0.2, animations: {
            self.selectionIcon.transform = .init(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.selectionIcon.transform = .init(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
}
