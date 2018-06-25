//
//  DateCalculator.swift
//  iOS-PetDay
//
//  Created by Fidetro on 04/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit

class Day: NSObject {
    let year : Int
    let month : Int
    let day : Int
    init(year: Int, month: Int,day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    func lastDay() -> Day? {
        
        var lastDay = self.day
        var lastMonth = self.month
        var lastYear = self.year
        if lastDay - 1 == 0 {
            
            if lastMonth - 1 == 0 {
                lastYear -= 1
                lastMonth = 12
                
                
            }else{
                lastMonth -= 1
                
            }
            let maxDay = Date.monthOfDays(month: lastMonth, year: lastYear)
            lastDay = maxDay
        }else{
            lastDay -= 1
        }
        if lastYear <= 1969 {
            return nil
        }else{
            return Day.init(year: lastYear, month: lastMonth, day: lastDay)
        }
        
    }
    func nextDay() -> Day? {
        let maxDay = Date.monthOfDays(month: self.month, year: self.year)
        var nextDay = self.day
        var nextMonth = self.month
        var nextYear = self.year
        if nextDay + 1 > maxDay {
            nextDay = 1
            if nextMonth + 1 > 12 {
                nextYear += 1
                nextMonth = 1
            }else{
                nextMonth += 1
            }
        }else{
            nextDay += 1
        }
        
        if nextYear > 2200,nextMonth > 12, nextDay > 31 {
            return nil
        }
        return Day.init(year: nextYear, month: nextMonth, day: nextDay)
    }
}

class DateCalculator: NSObject {
    
    
    let today : Day
    init(today:Date) {
        self.today = Day.init(year: today.year(), month: today.month(), day: today.day())
    }
    
    init(today:Day) {
        self.today = today
    }
    
    func lastDays(count:Int) -> [Day] {
        var days = [Day]()
      
        
        var lastDay : Day?
        for _ in 0..<count {
            if let last = lastDay {
                lastDay = last.lastDay()
                guard let day = lastDay else{
                    return days
                }
                days.insert(day, at: 0)
            }else{
                lastDay = Day.init(year: self.today.year,
                                   month: self.today.month,
                                   day: self.today.day)
            }
        }
        return days
    }
    
    func nextDays(count:Int) -> [Day] {
        var days = [Day]()
        var lastDay : Day?

        
        for _ in 0..<count {
            if let last = lastDay {
                lastDay = last.nextDay()
                guard let day = lastDay else{
                    return days
                }
                days.append(day)
            }else{
                lastDay = Day.init(year: self.today.year,
                                   month: self.today.month,
                                   day: self.today.day)
            }
        }
        return days
    }
    
    
}
