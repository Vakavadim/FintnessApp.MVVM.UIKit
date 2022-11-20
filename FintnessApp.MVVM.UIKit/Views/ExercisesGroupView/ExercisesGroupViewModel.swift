//
//  File.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import Foundation
import Firebase

protocol ExercisesGroupViewModelProtocol {
    func getRows()
    func numbersOfRows() -> Int
    var viewModelDidChange: ((ExercisesGroupViewModelProtocol) -> Void)? { get set }
    var rows: [ExerciseGroupCellViewModelProtocol] { get }
}

class ExercisesGroupViewModel: ExercisesGroupViewModelProtocol {
    
    var viewModelDidChange: ((ExercisesGroupViewModelProtocol) -> Void)?
    
    private var rowsStorage: [ExerciseGroupCellViewModelProtocol] = []
    
    var rows: [ExerciseGroupCellViewModelProtocol] {
        get {
            rowsStorage
        } set {
            rowsStorage = newValue
            print("set new value \(newValue.count)")
            viewModelDidChange?(self)
        }
    }
    
    
    
    func numbersOfRows() -> Int {
        10
    }
    
    func getRows() {
        NetworkDataManager.shared.ref.observe(.value, with: {(snapshot) in
            
            var armExercises: [Exercise] = []
            var legExercises: [Exercise] = []
            var shoulderExercises: [Exercise] = []
            var chestExercises: [Exercise] = []
            var backExercises: [Exercise] = []
            var absExercises: [Exercise] = []
            var stretching: [Exercise] = []
            var cardio: [Exercise] = []
            
            for item in snapshot.children {
                let exercise = Exercise(snapshot: item as! DataSnapshot)
                
                switch exercise.type {
                case "armExercise":
                    armExercises.append(exercise)
                case "legExercise":
                    legExercises.append(exercise)
                case "shoulderExercise":
                    shoulderExercises.append(exercise)
                case "chestExercise":
                    chestExercises.append(exercise)
                case "backExercise":
                    backExercises.append(exercise)
                case "absExercise":
                    absExercises.append(exercise)
                case "stretching":
                    stretching.append(exercise)
                case "cardio":
                    cardio.append(exercise)
                default:
                    print("default")
                }
            }
            
            let exerciseGroups = [
                ExerciseGroup(title: "Руки",
                              imageName: "questionmark.circle",
                              exercises: armExercises),
                ExerciseGroup(title: "Ноги",
                              imageName: "questionmark.circle",
                              exercises: legExercises),
                ExerciseGroup(title: "Плечи",
                              imageName: "questionmark.circle",
                              exercises: shoulderExercises),
                ExerciseGroup(title: "Грудь",
                              imageName: "questionmark.circle",
                              exercises: chestExercises),
                ExerciseGroup(title: "Спина",
                              imageName: "questionmark.circle",
                              exercises: backExercises),
                ExerciseGroup(title: "Пресс",
                              imageName: "questionmark.circle",
                              exercises: absExercises),
                ExerciseGroup(title: "Растяжка",
                              imageName: "questionmark.circle",
                              exercises: stretching),
                ExerciseGroup(title: "Кардио",
                              imageName: "questionmark.circle",
                              exercises: cardio),
            ]
            
            self.rows = exerciseGroups.map { ExerciseGroupCellViewModel(exerciseGroup: $0) }
        })
    }
}
