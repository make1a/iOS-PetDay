//
//  PhotoLibraryContainerView.swift
//  iOS-PetDay
//
//  Created by Fidetro on 09/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit
import SnapKit
import Photos

class PhotoLibraryContainerView: UIView {

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView.init(frame: .zero,
                                                   collectionViewLayout:flowLayout)
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoLibraryCollectionViewCell.self,
                                forCellWithReuseIdentifier: PhotoLibraryCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func snpLayoutSubview() {
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

}


