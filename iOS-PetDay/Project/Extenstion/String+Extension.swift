//
//  String+Extension.swift
//  iOS-PetDay
//
//  Created by Fidetro on 28/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import Foundation

extension String{
    
    subscript(index:Int) -> String? {
        return subString(index, to: index)
    }
    subscript (bounds: CountableClosedRange<Int>) -> String? {
        return subString( bounds.lowerBound, to: bounds.upperBound)
    }
    
    subscript (bounds: CountableRange<Int>) -> String? {
        return subString( bounds.lowerBound, to: bounds.upperBound)
    }
    
    func to(_ index:Int) -> String? {
        let toIndex = String.Index.init(encodedOffset: index)
        guard toIndex < self.endIndex else { return nil }
        return String(self[...toIndex])
        
    }
    func from(_ index:Int) -> String? {
        let fromIndex = String.Index.init(encodedOffset: index)
        guard fromIndex < self.endIndex else { return nil }
        return String(self[fromIndex..<self.endIndex])
    }
    func subString(_ from:Int,to:Int) -> String? {
        let toIndex = String.Index.init(encodedOffset: from)
        let fromIndex = String.Index.init(encodedOffset: to)
        guard toIndex < self.endIndex,
            fromIndex < self.endIndex,
            toIndex <= fromIndex else { return nil }
        return String(self[toIndex...fromIndex])
    }
}
