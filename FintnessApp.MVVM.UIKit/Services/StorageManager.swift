//
//  StorageManager.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import RealmSwift
import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    let realm = try! Realm()
    
    func saveWorkoutList(_ workoutList: WorkoutList) {
        try! self.realm.write {
            self.realm.add(workoutList)
        }
    }
    
    func saveWorkout(_ workout: Workout, for workoutList: WorkoutList) {
        try! realm.write {
            workoutList.workouts.append(workout)
            print("add new workout")
        }
    }
    
    func setTestWorkouts() -> WorkoutList {
        let workoutList = WorkoutList()
        workoutList.listName = "Workout"
        workoutList.date = Date()
        
        let workout1 = Workout()
        workout1.type = "Chest"
        workout1.name = "Pushups"
        workout1.imageName = "list.bullet.circle"
        
        let workout2 = Workout()
        workout2.type = "Chest"
        workout2.name = "Some Exercises"
        workout2.imageName = "list.bullet.circle"
        
        let workout3 = Workout()
        workout3.type = "Chest"
        workout3.name = "Pull over"
        workout3.imageName = "list.bullet.circle"
        
        workoutList.workouts.append(workout1)
        workoutList.workouts.append(workout2)
        workoutList.workouts.append(workout3)
        
//        saveWorkoutList(workoutList)
        
        return workoutList
    }
    
}
