//
//  CalendarIntroductionCollectionViewCell.swift
//  Calendar
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

class CalendarIntroductionCollectionViewCell: UICollectionViewCell {
    static let identifier = "kCalendarIntroductionCollectionViewCellIdentifier"
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .themeBlackColor()
        titleLabel.textColor = .white
        titleLabel.font = .themeFont(ofSize: 17)
        return titleLabel
    }()
    var shapeLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        snpLayoutSubview()

    }
  
    
    static func dequeueReusable(withCollectionView collectionView:UICollectionView,for indexPath:IndexPath) -> CalendarIntroductionCollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CalendarIntroductionCollectionViewCell.identifier, for: indexPath) as! CalendarIntroductionCollectionViewCell
    }
  

    
    func updateDay(_ day:Int) {      
        titleLabel.text =  day == 0 ? "" : "\(day)"
    }
    
    func draw() {
        let rrect = bounds
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint.init(x: bounds.size.width/2, y: bounds.size.height/2)
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        let kArrorHeight = CGFloat.init(20)
        let path =  CGMutablePath()
        let midx = rrect.midX
        let maxy = rrect.maxY+1

        path.move(to: CGPoint.init(x: midx+kArrorHeight, y: maxy))
        path.addLine(to: CGPoint.init(x: midx, y:  maxy-kArrorHeight))
        path.addLine(to: CGPoint.init(x: midx-kArrorHeight, y:  maxy))
        shapeLayer.path = path
        shapeLayer.name = "Dash"
        self.layer.addSublayer(shapeLayer)
    }
     func removeAnimationLayer() {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if let layername = layer.name,layername == "Dash" {
                    layer.removeFromSuperlayer()
                }
            }
        }
//        CATransaction.begin()
//        let animation = CABasicAnimation()
//        animation.duration = 0.2
//        animation.isRemovedOnCompletion = false
//        animation.keyPath = "position.y"
//        animation.fillMode = kCAFillModeForwards
//
//        CATransaction.setCompletionBlock {
//            if let sublayers = self.layer.sublayers {
//                for layer in sublayers {
//                    if let layername = layer.name,layername == "Dash" {
//                        layer.removeFromSuperlayer()
//                    }
//                }
//            }
//        }
//        if let sublayers = self.layer.sublayers {
//            for layer in sublayers {
//                if let layername = layer.name,layername == "Dash" {
//                    layer.add(animation, forKey: "slide")
//                }
//            }
//        }
//        CATransaction.commit()
    }
    
    func removeLayer() {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if let layername = layer.name,layername == "Dash" {
                    layer.removeFromSuperlayer()
                }
            }
        }
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
