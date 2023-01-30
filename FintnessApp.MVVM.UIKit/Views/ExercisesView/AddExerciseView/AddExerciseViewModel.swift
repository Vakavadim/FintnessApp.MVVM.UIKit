//
//  AddExerciseViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.01.2023.
//

import UIKit
import RealmSwift

protocol AddExerciseViewModelProtocol {
    func addExercise(setsCount: String?, weight: String?, time: String?, range: String?)
    func getType() -> String
    func getExerciseImage() -> UIImage
    func getExerciseTitle() -> String
    func getExerciseDescription() -> String
    init(exercise: Exercise)
}

class AddExerciseViewModel: AddExerciseViewModelProtocol {
    
    
    private var exercise: Exercise
    
    private func saveExercise(workoutLists: Results<WorkoutList>, workout: Workout) {
        if workoutLists.first != nil {
            StorageManager.shared.saveWorkout(workout, for: workoutLists.first!)
        } else {
            let workoutList = WorkoutList()
            workoutList.date = UDDateManager.shared.getSelectedDate()
            workoutList.listName = "workoutList"
            workoutList.weight = 90.0
            workoutList.workouts.append(workout)
            StorageManager.shared.saveWorkoutList(workoutList)
        }
    }

    func addExercise(setsCount: String?, weight: String?, time: String?, range: String?) {
        
        let workout = Workout()
        
        workout.name = exercise.title
        workout.desc = exercise.description
        workout.imageName = exercise.imageName
        if exercise.type == "cardio" {
            guard let time = time, let range = range else { return }
            workout.time = Int(time)
            workout.range = Int(range)
        } else {
            guard let weight = weight, let setsCount = setsCount else { return }
            workout.weght = Int(weight)
            workout.count = Int(setsCount)
        }
        
        let selectedDate = UDDateManager.shared.getSelectedDate()
        let workoutLists = StorageManager.shared.realm.objects(WorkoutList.self).where {
            $0.date == selectedDate
        }
        
        saveExercise(workoutLists: workoutLists, workout: workout)
    }

    func getType() -> String {
        exercise.type
    }
    
    func getExerciseImage() -> UIImage {
        guard let image = UIImage(systemName: exercise.imageName) else { return UIImage() }
        return image
    }
    
    func getExerciseTitle() -> String {
        return exercise.title
    }
    
    func getExerciseDescription() -> String {
        return exercise.description
    }
    
    required init(exercise: Exercise) {
        self.exercise = exercise
    }
}
