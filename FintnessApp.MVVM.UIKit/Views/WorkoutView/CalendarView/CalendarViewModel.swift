//
//  CalendarViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import Foundation

protocol CalendarViewModelProrocol: AnyObject {
    var currentDate: Date { get }
    var selectedDate: Date { get set }
    var calendarExpand: Bool { get }
    var dateString: String { get }
    func getCalendarItemsCount() -> Int
    func getCalendarCellViewModel(at indexPath: IndexPath) -> CalendarCellViewModelProtocol
    func cellDidSelected(at indexPath: IndexPath)
    func nextMonth(selectedDate: Date) -> Date
    func previusMonth(selectedDate: Date) -> Date
    func calendarChangeSize(state: Bool)
    var viewModelDidChange: ((CalendarViewModelProrocol) -> Void)? { get set }
    
}

class CalendarViewModel: CalendarViewModelProrocol {
    
    
    private var totalSquares: [CalendarCellData] {
        calendarExpand ? setMonthView() : setWeekView()
    }
    
    private var calendarExpandStorage = false
    
    var viewModelDidChange: ((CalendarViewModelProrocol) -> Void)?
    
    var currentDate: Date {
        CalendarManager.shared.currentDate(date: Date())
    }
    
    var selectedDate: Date {
        get {
            UDDateManager.shared.getSelectedDate()
        } set {
            UDDateManager.shared.setSelectedDate(date: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var calendarExpand: Bool {
        get {
            calendarExpandStorage
        } set {
            calendarExpandStorage = newValue
            viewModelDidChange?(self)
        }
    }
    
    var dateString: String {
        CalendarManager.shared.monthString(date: selectedDate) + " " + CalendarManager.shared.yearString(date: selectedDate)
    }
    
    func getCalendarItemsCount() -> Int {
        totalSquares.count
    }
    
    func getCalendarCellViewModel(at indexPath: IndexPath) -> CalendarCellViewModelProtocol {
        let viewModel = CalendarCellViewModel(cellData: totalSquares[indexPath.item])
        return viewModel
    }
    
    private func setWeekView() -> [CalendarCellData] {
        var totalSquares: [CalendarCellData] = []
        var current = CalendarManager.shared.mondayForDate(date: selectedDate)
        let nextMonday = CalendarManager.shared.addDay(date: current, days: 7)
        
        while current < nextMonday {
            totalSquares.append(CalendarCellData(date: current))
            current = CalendarManager.shared.addDay(date: current, days: 1)
        }
        return totalSquares
    }
    
    private func setMonthView() -> [CalendarCellData] {
        var totalSquares: [CalendarCellData] = []
        var current = CalendarManager.shared.firstOfMonth(date: selectedDate)
        let nextMonth = CalendarManager.shared.addMonth(date: current, month: 1)
        
        while current < nextMonth {
            totalSquares.append(CalendarCellData(date: current))
            current = CalendarManager.shared.addDay(date: current, days: 1)
        }
        
        let weekDay = totalSquares[0].weekDay!
        let getTheWeekday = Weekdays(rawValue: weekDay)
        let passesNumber = getTheWeekday?.getNumberOfPasses()
        
        for _ in 1...passesNumber! {
            totalSquares.insert(CalendarCellData(date: nil), at: 0)
        }
        
        return totalSquares
    }
    
    func nextMonth(selectedDate: Date) -> Date {
        CalendarManager.shared.addMonth(date: selectedDate, month: 1)
    }
    
    func previusMonth(selectedDate: Date) -> Date {
        CalendarManager.shared.addMonth(date: selectedDate, month: -1)
    }
    
    func calendarChangeSize(state: Bool) {
        calendarExpand = state
    }
    
    func cellDidSelected(at indexPath: IndexPath) {
        guard let date = totalSquares[indexPath.item].date else { return }
        selectedDate = date
        print(indexPath.item)
        print(totalSquares[indexPath.item].date!)
    }
    
    deinit {
        print("Class was deinit")
    }
}
