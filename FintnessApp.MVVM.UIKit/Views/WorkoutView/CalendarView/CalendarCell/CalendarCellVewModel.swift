//
//  CalendarCellVewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 19.10.2022.
//

import Foundation

protocol CalendarCellViewModelProtocol {
    var dayNumber: String { get }
    var workoutIndicator: Bool { get }
    var selectedIndicator: Bool { get }
    var currentDayIndicator: Bool { get }
    init(cellData: CalendarCellData)
    func dayСontainsWorkouts()
}

class CalendarCellViewModel: CalendarCellViewModelProtocol {
    
    private var cellData: CalendarCellData
    
    var dayNumber: String {
        cellData.text
    }
    
    var selectedIndicator: Bool {
        let selectedDate = UDDateManager.shared.getSelectedDate()
        return cellData.date == selectedDate
    }
    
    var currentDayIndicator: Bool {
        get {
            cellData.date == CalendarManager.shared.currentDate(date: Date())
        }
    }
    
    var workoutIndicator: Bool {
        get {
            false
        } set {

        }
    }

    
    func dayСontainsWorkouts() {
        workoutIndicator.toggle()
    }
    
    required init(cellData: CalendarCellData) {
        self.cellData = cellData
    }
    
    
}
