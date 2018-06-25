//
//  PhotoLibraryTool.swift
//  iOS-PetDay
//
//  Created by make on 2018/3/28.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import UIKit

class PhotoLibraryTool: NSObject {
    /// 计算新旧位置的差值
    ///
    /// - Parameters:
    ///   - old: old description
    ///   - new: new description
    /// - Returns: return value description
   static func differencesBetweenRects(_ old: CGRect, _ new: CGRect) -> (added: [CGRect], removed: [CGRect]) {
        
        // 新旧有交集
        if old.intersects(new) {
            
            // 增加值
            var added = [CGRect]()
            if new.maxY > old.maxY {
                added += [CGRect(x: new.origin.x, y: old.maxY, width: new.width, height: new.maxY - old.maxY)]
            }
            if new.minY < old.minY {
                added += [CGRect(x: new.origin.x, y: new.minY, width: new.width, height: old.minY - new.minY)]
            }
            
            // 移除值
            var removed = [CGRect]()
            if new.maxY < old.maxY {
                removed += [CGRect(x: new.origin.x, y: new.maxY, width: new.width, height: old.maxY - new.maxY)]
            }
            if new.minY > old.minY {
                removed += [CGRect(x: new.origin.x, y: old.minY, width: new.width, height: new.minY - old.minY)]
            }
            
            return (added, removed)
        }
        
        // 没有交集
        return ([new], [old])
    }
}
