//
//  NetworkDataManager.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 04.11.2022.
//

import Foundation
import Firebase

class NetworkDataManager {
    
    static let shared = NetworkDataManager()
    private init() {}
    
    private var ref = Database.database().reference(withPath: "workouts").child("exercises")
    
    func getExersice() -> [ExerciseTypeRow] {
        
        var exerciseGroups: [ExerciseTypeRow] = []
        
        self.ref.observe(.value, with: {(snapshot) in
            
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
            
            let _exerciseGroups = [
                ExerciseTypeRow(title: "Руки",
                                imageName: "questionmark.circle",
                                exercise: armExercises),
                ExerciseTypeRow(title: "Ноги",
                                imageName: "questionmark.circle",
                                exercise: legExercises),
                ExerciseTypeRow(title: "Плечи",
                                imageName: "questionmark.circle",
                                exercise: shoulderExercises),
                ExerciseTypeRow(title: "Грудь",
                                imageName: "questionmark.circle",
                                exercise: chestExercises),
                ExerciseTypeRow(title: "Спина",
                                imageName: "questionmark.circle",
                                exercise: backExercises),
                ExerciseTypeRow(title: "Пресс",
                                imageName: "questionmark.circle",
                                exercise: absExercises),
                ExerciseTypeRow(title: "Растяжка",
                                imageName: "questionmark.circle",
                                exercise: stretching),
                ExerciseTypeRow(title: "Кардио",
                                imageName: "questionmark.circle",
                                exercise: cardio),
            ]
            
            exerciseGroups = _exerciseGroups
        })
        
        return exerciseGroups
    }
}
