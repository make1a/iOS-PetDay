//
//  Date+Extension.swift
//  Calendar
//
//  Created by Fidetro on 25/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import UIKit

extension Date {
    func weekDay() -> Int {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        return calendar.component(.weekday, from: self)
    }
    
    static func startOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]), from: date)        
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    func year() -> Int {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents(Set<Calendar.Component>([ .year]), from: self)
        return components.year!
    }
     func month() -> Int {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents(Set<Calendar.Component>([ .month]), from: self)
        return components.month!
    }
    func day() -> Int {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents(Set<Calendar.Component>([ .day]), from: self)
        return components.day!
    }
    func nextMonth() -> Date {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]), from: self)
        if components.month! == 12 {
            components.year! += 1
            components.month! = 1
        }else{
            components.month! += 1
        }
       return calendar.date(from: components)!
    }
    
    func lastMonth() -> Date {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]), from: self)
        if components.month! == 1 {
            components.year! -= 1
            components.month! = 12
        }else{
            components.month! -= 1
        }
        return calendar.date(from: components)!
    }
    
    func MaxDayOfMonth() -> Int {
        let  calendar = Calendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]), from: self)
        return Date.monthOfDays(month: components.month!, year: components.year!)
    }
    static func monthOfDays(month:Int,year:Int) -> Int {
        switch month {
        case 2:
            return year % 4 == 0 ? 29 : 28
        case 1,3,5,7,8,10,12:
            return 31
        default:
            return 30
        }
    }
}
