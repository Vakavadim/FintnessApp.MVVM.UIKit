//
//  Workout.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 12.10.2022.
//

import RealmSwift
import Foundation

class Workout: Object {
    @Persisted var type: String
    @Persisted var name: String
    @Persisted var imageName: String
    @Persisted var desc: String
    @Persisted var count: Int?
    @Persisted var weght: Int?
    @Persisted var time: Int?
    @Persisted var range: Int?
}
