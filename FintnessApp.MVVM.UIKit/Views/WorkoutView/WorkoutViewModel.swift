//
//  WorkoutViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 10.10.2022.
//

import Foundation
import RealmSwift

protocol WorkoutViewModelProtocol {
    func numbersOfRows() -> Int
    func getWorkouts()
    func getWorkoutCellViewModel(at indexPath: IndexPath) -> WorkoutCellViewModelProtocol
}

class WorkoutViewModel: WorkoutViewModelProtocol {
    
    private var workoutList: Results<WorkoutList>!

    func numbersOfRows() -> Int {
        (workoutList.first?.workouts.count)!
    }
    
    func getWorkouts() {
        workoutList = StorageManager.shared.realm.objects(WorkoutList.self)
    }
    
    func getWorkoutCellViewModel(at indexPath: IndexPath) -> WorkoutCellViewModelProtocol {
        WorkoutCellViewModel(workout: (workoutList.first?.workouts[indexPath.row])!)
    }
    
}