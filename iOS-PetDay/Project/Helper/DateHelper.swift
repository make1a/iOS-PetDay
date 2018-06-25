//
//  DateHelper.swift
//  Calendar
//
//  Created by Fidetro on 20/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    static let shared = DateHelper()
    private override init() {
        
    }
    lazy var today: Date = {
        let date = Date()
        return date
    }()
    
    lazy var firstDayForCurrentMonth: Date = {
        return Date.startOfCurrentMonth()
    }()
    
    func next() {
        firstDayForCurrentMonth = firstDayForCurrentMonth.nextMonth()
        today = DateHelper.shared.firstDayForCurrentMonth
    }
    
    func last() {
        firstDayForCurrentMonth = firstDayForCurrentMonth.lastMonth()
        today = DateHelper.shared.firstDayForCurrentMonth
    }
    
    
}
