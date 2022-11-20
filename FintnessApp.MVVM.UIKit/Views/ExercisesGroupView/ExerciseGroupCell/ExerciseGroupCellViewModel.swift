//
//  ExerciseCellViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 04.11.2022.
//

import Foundation

protocol ExerciseGroupCellViewModelProtocol {
    var identifier: String { get }
    var height: Double { get }
    var exerciseGroupName: String { get }
    var imageName: String { get }
    var exercises: [Exercise] { get }
    init(exerciseGroup: ExerciseGroup)
}

class ExerciseGroupCellViewModel: ExerciseGroupCellViewModelProtocol {
    
    var identifier: String {
        "ExerciseGroupCell"
    }
    
    var height: Double {
        100
    }
    
    var exerciseGroupName: String {
        exerciseGroup.title
    }
    
    var imageName: String {
        exerciseGroup.imageName
    }
    
    var exercises: [Exercise] {
        exerciseGroup.exercises
    }
    
    private let exerciseGroup: ExerciseGroup
    
    required init(exerciseGroup: ExerciseGroup) {
        self.exerciseGroup = exerciseGroup
    }
}
