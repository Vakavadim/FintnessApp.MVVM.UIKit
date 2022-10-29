//
//  CalendarCellData.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 15.10.2022.
//

import Foundation

struct CalendarCellData {
    var date: Date?
    var weekDay: Int? {
        let calendar = Calendar.current
        var weekDay: Int? = nil
        if let date = date {
            weekDay = calendar.dateComponents([.weekday], from: date).weekday!
        } else {
            weekDay = nil
        }
        return weekDay
    }
    var text: String {
        let calendar = Calendar.current
        var text = ""
        if let date = date {
            text = String(calendar.dateComponents([.day], from: date).day!)
        } else {
            text = ""
        }
        return text
    }
}
