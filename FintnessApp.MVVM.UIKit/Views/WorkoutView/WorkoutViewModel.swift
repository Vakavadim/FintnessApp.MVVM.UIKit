//
//  WorkoutViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 10.10.2022.
//

import Foundation
import RealmSwift

protocol WorkoutViewModelProtocol: AnyObject {
    func numbersOfRows() -> Int
    func getWorkouts()
    func getWeightValue() -> Double
    func setWeightValue(weigth: Double)
    func getWorkoutCellViewModel(at indexPath: IndexPath) -> WorkoutCellViewModelProtocol
}

class WorkoutViewModel: WorkoutViewModelProtocol {
    
    private var workoutList: Results<WorkoutList>!
    
    var viewModelDidChange: ((WorkoutViewModelProtocol) -> Void)?

    func numbersOfRows() -> Int {
        guard let workouts = workoutList.first?.workouts.count else { return 10 }
        return workouts
    }
    
    func getWeightValue() -> Double {
        guard let workoutList = self.workoutList.first else { return 90 }
        return workoutList.weight
    }
    
    func setWeightValue(weigth: Double) {
        guard let workoutList = self.workoutList.first else { return }
        StorageManager.shared.editWorkoutListWeigth(workoutList, with: weigth)
        print(workoutList.weight)
    }
    
    func getWorkouts() {
        let selectedDate = UDDateManager.shared.getSelectedDate()
        let workoutLists = StorageManager.shared.realm.objects(WorkoutList.self)
        let workoutList = workoutLists.where {
            $0.date == selectedDate
        }
        self.workoutList = workoutList
        
    }
    
    func getWorkoutCellViewModel(at indexPath: IndexPath) -> WorkoutCellViewModelProtocol {
        let dummyWorkout = Workout()
        
        guard let workout = workoutList.first?.workouts[indexPath.row] else { return WorkoutCellViewModel(workout: dummyWorkout)}
        let viewModel = WorkoutCellViewModel(workout: workout)
        return viewModel
    }
    
}
