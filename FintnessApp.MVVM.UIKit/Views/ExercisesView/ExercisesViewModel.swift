//
//  File.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import Foundation

protocol ExercisesViewModelProtocol {
    func getWorkouts() -> [Exercise]
    func numbersOfRows() -> Int
}

class ExercisesViewModel: ExercisesViewModelProtocol {
    
    func numbersOfRows() -> Int {
        10
    }
    
    func getWorkouts() -> [Exercise] {
        let workouts = [Exercise(title: "title", type: "Type", imageName: "image", description: "des")]
        return workouts
    }

}
