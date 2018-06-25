//
//  PreviewPhotosCell.swift
//  iOS-PetDay
//
//  Created by make on 2018/3/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let singleTap =  #selector(PreviewPhotosCell.singleTap(tap:))
    static let doubleTap =  #selector(PreviewPhotosCell.doubleTap(tap:))
    
}

let statusBarHeight = CGFloat(0)

class PreviewPhotosCell: UICollectionViewCell {
    //照片的标识
    var representAssetIdentifier: String!
    
    static let identifier = "kPerviewCollectionViewCellIdentifier"
    
    var singleTap_block : (()->())? = nil
    
//    var photoImage : UIImage?
    
    lazy var photoImageView: UIImageView = {
        var photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(photoImageView)
        scrollView.backgroundColor = UIColor.clear
        return photoImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 2.5
        scrollView.minimumZoomScale = 1.0
        scrollView.isScrollEnabled = true
        let tap1 = UITapGestureRecognizer.init(target: self, action: .singleTap)
        addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer.init(target: self, action: .doubleTap)
        tap2.numberOfTapsRequired = 2
        tap1.require(toFail: tap2)
        addGestureRecognizer(tap2)
        contentView.addSubview(scrollView)
        return scrollView
    }()
    
    //MARK:init
    static func dequeueReusable(withCollectionView collectionView:UICollectionView,for indexPath:IndexPath) -> PreviewPhotosCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: PreviewPhotosCell.identifier, for: indexPath) as! PreviewPhotosCell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        snpLayoutSubview()
    }
    
    //MARK:action
    @objc func singleTap(tap:UITapGestureRecognizer) {
        if let block = singleTap_block {
            block()
        }
    }
    @objc func doubleTap(tap:UITapGestureRecognizer) {
        if self.scrollView.zoomScale > 1.0 {
            self.scrollView.setZoomScale(1.0, animated: true)
        } else {
            let touchPoint = tap.location(in: self.photoImageView)
            let newZoomScale = self.scrollView.maximumZoomScale
            let xsize = self.contentView.frame.size.width / newZoomScale
            let ysize = self.contentView.frame.size.height / newZoomScale
            //            self.scrollView.setZoomScale(1.5, animated: true)
            self.scrollView.zoom(to: CGRect.init(x: touchPoint.x - xsize/2, y: touchPoint.y - ysize/2, width: xsize, height: ysize), animated: true)
        }
    }
    
    func snpLayoutSubview() {
        scrollView.frame = contentView.frame
        photoImageView.frame.size.width = contentView.frame.size.width
        
        let image = UIImage.init(named: "ms")
        setupImage(image)
    }
    
    func setupImage(_ photoImage: UIImage? = nil) {
        if photoImage == nil {
            return
        }
        var image = UIImage()
        if  let cacheImage = photoImage {
            image = cacheImage
        }
        photoImageView.image = image
        let zoomScale = contentView.frame.size.width / image.size.width
        let zoomHeight = zoomScale * image.size.height
        scrollView.contentSize = CGSize.init(width: contentView.frame.size.width, height: zoomHeight)
        photoImageView.frame.size.height = zoomHeight
        
        if zoomHeight > contentView.frame.size.height {
            photoImageView.center.y = zoomHeight / 2
        }else{
            photoImageView.center.y = contentView.center.y
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension PreviewPhotosCell:UIScrollViewDelegate{

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = photoImageView.frame
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        }else {
            contentsFrame.origin.y = 0.0
        }
        self.photoImageView.frame = contentsFrame
    }
    
}
