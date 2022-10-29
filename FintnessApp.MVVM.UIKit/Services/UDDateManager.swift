//
//  DataManager.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 28.10.2022.
//

import Foundation

final class UDDateManager {
    
    static let shared = UDDateManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setSelectedDate(date: Date) {
        userDefaults.set(date, forKey: "selectedDate")
    }
    
    func getSelectedDate() -> Date {
        guard let date = userDefaults.object(forKey: "selectedDate") as? Date
        else { return CalendarManager.shared.currentDate(date: Date())}
        return date
    }
    
    func unsetSelectedDate() {
        userDefaults.removeObject(forKey: "selectedDate")
    }
}
