//
//  StorageManager.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    let realm = try! Realm()
    
    func saveWorkoutList(_ workoutList: WorkoutList) {
        try! self.realm.write {
            self.realm.add(workoutList)
        }
    }
    
    func saveTask(_ workout: Workout, for workoutList: WorkoutList) {
        try! realm.write {
            workoutList.workouts.append(workout)
        }
    }
}
