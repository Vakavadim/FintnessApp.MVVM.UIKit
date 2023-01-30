//
//  WorkoutCellViewModel.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 12.10.2022.
//

import Foundation

protocol WorkoutCellViewModelProtocol {
    var workoutName: String { get }
    var imageName: String { get }
    var exposition: String  { get }
    var weight: Int? { get }
    var count: Int? { get }
    var range: Int? { get }
    var time: Int? { get }
    var workoutDescription: String { get }
    init(workout: Workout)
}

class WorkoutCellViewModel: WorkoutCellViewModelProtocol {
    
    private let workout: Workout
    
    var workoutDescription: String {
        if workout.type == "cardio" {
            guard let time = workout.time, let range = workout.range else {return "добавьте данные о тренировке"}
            return "Время: \(time) минут, Расстояние: \(range) метров"
        } else {
            guard let count = workout.count, let weight = workout.weight else {return "добавьте данные о тренировке"}
            return "Количество подходов: \(count), Вес: \(weight) килограмм"
        }
    }
    
    var workoutName: String {
        workout.name
    }
    
    var imageName: String {
        workout.imageName
    }
    
    var exposition: String {
        workout.description
    }
    
    var weight: Int? {
        workout.weight
    }
    
    var count: Int? {
        workout.count
    }
    
    var range: Int? {
        workout.range
    }
    
    var time: Int? {
        workout.time
    }
    
    required init(workout: Workout) {
        self.workout = workout
    }
    
    
}
