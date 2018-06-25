//
//  EmptyCollectionReusableView.swift
//  Calendar
//
//  Created by Fidetro on 25/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

class EmptyCollectionReusableView: UICollectionReusableView {
    static let identifier = "kEmptyCollectionReusableViewIdentifier"
    static func dequeueReusable(withCollectionView collectionView:UICollectionView,
                                for indexPath:IndexPath) -> EmptyCollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: EmptyCollectionReusableView.identifier,
            for: indexPath) as! EmptyCollectionReusableView
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func snpLayoutSubview() {
        
    }
}
