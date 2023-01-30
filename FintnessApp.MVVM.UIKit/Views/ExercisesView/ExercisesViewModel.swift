//
//  ExercisesGroupViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 15.11.2022.
//

import Foundation

protocol ExercisesViewModelProtocol {
    var exercise: [Exercise] { get set }
    func getCellViewModel(indexPath: IndexPath) -> ExerciseCellViewModelProtocol
    func getExercise(by indexPath: IndexPath) -> Exercise
    init(exercise: [Exercise])
}

class ExercisesViewModel: ExercisesViewModelProtocol {
    
    func getExercise(by indexPath: IndexPath) -> Exercise {
        return exercise[indexPath.row]
    }
    
    func getCellViewModel(indexPath: IndexPath) -> ExerciseCellViewModelProtocol {
        ExerciseCellViewModel(exercise: exercise[indexPath.row])
    }
    
    var exercise: [Exercise]

    required init(exercise: [Exercise]) {
        self.exercise = exercise
    }
}
