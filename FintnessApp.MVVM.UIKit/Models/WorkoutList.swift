//
//  WorkoutList.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 12.10.2022.
//

import RealmSwift
import Foundation

class WorkoutList: Object {
    @Persisted var listName: String
    @Persisted var date: Date
//    @Persisted var weight: Double
    @Persisted var workouts = List<Workout>()
}
