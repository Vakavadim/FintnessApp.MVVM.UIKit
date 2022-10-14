//
//  WorkoutCellViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 12.10.2022.
//

import Foundation

protocol WorkoutCellViewModelProtocol {
    var workoutName: String { get }
    var imageName: String { get }
    init(workout: Workout)
}

class WorkoutCellViewModel: WorkoutCellViewModelProtocol {
    private let workout: Workout
    
    var workoutName: String {
        workout.name
    }
    
    var imageName: String {
        workout.imageName
    }
    
    required init(workout: Workout) {
        self.workout = workout
    }
    
    
}
