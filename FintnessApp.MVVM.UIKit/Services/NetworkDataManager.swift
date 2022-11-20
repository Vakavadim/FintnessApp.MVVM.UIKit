//
//  NetworkDataManager.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 04.11.2022.
//

import Foundation
import Firebase

final class NetworkDataManager {
    
    static let shared = NetworkDataManager()
    private init() {}
    
    var ref = Database.database().reference(withPath: "workouts").child("exercises")
    
}
