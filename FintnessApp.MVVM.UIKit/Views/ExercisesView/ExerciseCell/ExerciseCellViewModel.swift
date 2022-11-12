//
//  ExerciseCellViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 04.11.2022.
//

import Foundation

protocol ExerciseCellViewModelProtocol {
    var identifier: String { get }
    var height: Double { get }
    var exerciseType: String { get }
    var exerciseName: String { get }
    var imageName: String { get }
    init(exercise: Exercise)
}

class ExerciseCellViewModel: ExerciseCellViewModelProtocol {
    
    var identifier: String {
        "ExerciseCell"
    }
    
    var height: Double {
        100
    }
    
    var exerciseType: String {
        exercise.type
    }
    
    var exerciseName: String {
        exercise.title
    }
    
    var imageName: String {
        exercise.imageName
    }
    
    var description: String {
        exercise.description
    }
    
    private let exercise: Exercise
    
    required init(exercise: Exercise) {
        self.exercise = exercise
    }
}
