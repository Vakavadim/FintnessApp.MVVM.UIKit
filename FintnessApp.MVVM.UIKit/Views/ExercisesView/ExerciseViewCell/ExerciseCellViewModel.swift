//
//  ExerciseCellViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 17.11.2022.
//

import Foundation

protocol ExerciseCellViewModelProtocol {
    var exercise: Exercise { get }
    init(exercise: Exercise)
}

class ExerciseCellViewModel: ExerciseCellViewModelProtocol {
    
    var exercise: Exercise
    
    required init(exercise: Exercise) {
        self.exercise = exercise
    }
}
