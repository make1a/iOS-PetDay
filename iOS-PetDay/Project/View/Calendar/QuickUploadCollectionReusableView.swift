//
//  QuickUploadCollectionReusableView.swift
//  Calendar
//
//  Created by Fidetro on 25/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit
fileprivate extension Selector {
    static let updateLocationAction = #selector(QuickUploadCollectionReusableView.updateLocationAction(sender:))
    static let selectPhotoAction = #selector(QuickUploadCollectionReusableView.selectPhotoAction(sender:))
}


class QuickUploadCollectionReusableView: UICollectionReusableView {
    
    var selectPhoto_block : ((_:UIButton,_:UILabel)-> ())?
    var updateLocation_block : ((_:UIButton)-> ())?
    
    
    lazy var countLabel: UILabel = {
        var countLabel = UILabel()
        addSubview(countLabel)
        countLabel.text = "0/9"
        countLabel.textColor = .placeholderColor()
        return countLabel
    }()
    
    
    
    
    lazy var locationButton: UIButton = {
        var locationButton = UIButton.init(type: .custom)
        addSubview(locationButton)
        locationButton.addTarget(self, action: .updateLocationAction, for: .touchUpInside)
        locationButton.setImage(UIImage.init(named: "icon_location"), for: .normal)
        return locationButton
    }()
    
    lazy var pictureButton: UIButton = {
        var pictureButton = UIButton.init(type: .custom)
        addSubview(pictureButton)
        pictureButton.addTarget(self, action: .selectPhotoAction, for: .touchUpInside)
        pictureButton.setImage(UIImage.init(named: "icon_picture"), for: .normal)
        return pictureButton
    }()
    
    
    lazy var textField: UITextField = {
        var textField = UITextField()
        addSubview(textField)
        textField.placeholder = MyLocalizedString("New Event")
        textField.clearButtonMode = .whileEditing
        textField.tintColor = .placeholderColor()
        return textField
    }()
    
    static let identifier = "kQuickUploadCollectionReusableViewIdentifier"
    static func dequeueReusable(withCollectionView collectionView:UICollectionView,
                                for indexPath:IndexPath) -> QuickUploadCollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: QuickUploadCollectionReusableView.identifier,
            for: indexPath) as! QuickUploadCollectionReusableView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            snpLayoutSubview()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func height() -> CGFloat {
        return CGFloat(80)
    }
   
    
    @objc func updateLocationAction(sender:UIButton) {
        if let block = self.updateLocation_block {
            block(sender)
        }
    }
    
    
    @objc func selectPhotoAction(sender:UIButton) {
        if let block = self.selectPhoto_block {
            block(sender,countLabel)
        }
    }
    
    
    func snpLayoutSubview() {
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
        backgroundColor = .white
        let space = 10
       
        pictureButton.snp.makeConstraints{
           $0.right.equalTo(countLabel.snp.left).offset(-space)
            $0.width.equalTo(30)
            $0.centerY.equalTo(textField)
        }
        locationButton.snp.makeConstraints{
            $0.right.equalTo(pictureButton.snp.left).offset(-space)
            $0.width.equalTo(30)
            $0.centerY.equalTo(textField)
        }
        countLabel.snp.makeConstraints{
             $0.right.equalToSuperview().offset(-space)
            $0.width.equalTo(30)
            $0.centerY.equalTo(textField)
        }
        textField.snp.makeConstraints{
            $0.top.equalTo((QuickUploadCollectionReusableView.height()-50)/2)
            $0.left.equalToSuperview().offset(15)
            $0.height.equalTo(50)
            $0.right.equalTo(locationButton.snp.left).offset(-space)
        }

    }
    
    
    
}
