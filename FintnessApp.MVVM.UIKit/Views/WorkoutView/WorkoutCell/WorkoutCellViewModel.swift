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
    var exposition: String  { get }
    var weight: Int? { get set }
    var count: Int? { get set }
    var range: Int? { get set }
    var time: Int? { get set }
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
    
    var exposition: String {
        workout.description
    }
    
    var weight: Int?
    
    var count: Int?
    
    var range: Int?
    
    var time: Int?
    
    required init(workout: Workout) {
        self.workout = workout
    }
    
    
}
