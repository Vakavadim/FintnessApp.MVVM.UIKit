//
//  CalendarManager.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 15.10.2022.
//

import Foundation

final class CalendarManager {
    
    static let shared = CalendarManager()
    private init() {}
    
    private let calendar = Calendar.current
    
    
    // add number of month
    func addMonth(date: Date, month: Int) -> Date {
        return calendar.date(byAdding: .month, value: month, to: date)!
    }
    
    // add day
    func addDay(date: Date, days: Int) -> Date {
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    // get the month String from date
    func monthString(date: Date) -> String {
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = "LLLL"
        
        return dateFormator.string(from: date).capitalized
    }
    
    // get the year as a number in String from the date
    func yearString(date: Date) -> String {
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = "yyyy"
        
        return dateFormator.string(from: date)
    }
    
    // get the number of days in month in Int
    func daysInMonth(date: Date) -> Int {
        guard let range = calendar.range(of: .day, in: .month, for: date) else {return 0}
        return range.count
    }
    
    // the day of the month
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    
    // return the week day
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 2
    }
    
    // get the day of the month from day number
    func getDate(day: Int, date: Date) -> Date {
        let currentDayComponents = calendar.dateComponents([.year, .month], from: date)
        let dateCompnent = DateComponents(calendar: calendar,
                                          year: currentDayComponents.year,
                                          month: currentDayComponents.month,
                                          day: day)
        let dateFromDateComponents = calendar.date(from: dateCompnent)
        return dateFromDateComponents!
    }
    // return first day of month
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func mondayForDate(date: Date) -> Date {
        var current = date
        let oneWeekAgo = addDay(date: current, days: -7)
        
        while(current > oneWeekAgo) {
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            if currentWeekDay == Weekdays.monday.rawValue {
                return current
            }
            current = addDay(date: current, days: -1)
        }
        return current
    }
    
    func currentDate(date: Date) -> Date {
        let components = calendar.dateComponents([.day, .year, .month], from: date)
        return calendar.date(from: components)!
    }
}

enum Weekdays: Int {
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    case sunday = 1
    
    func getNumberOfPasses() -> Int {
        switch self {
            
        case .monday:
            return 0
        case .tuesday:
            return 1
        case .wednesday:
            return 2
        case .thursday:
            return 3
        case .friday:
            return 4
        case .saturday:
            return 5
        case .sunday:
            return 6
        }
    }
}
