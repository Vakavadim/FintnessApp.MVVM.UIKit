//
//  WorkoutTamplate.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 30.10.2022.
//

import Foundation
import Firebase

struct Exercise {
    var title: String
    var type: String
    var imageName: String
    var description: String
    let ref: DatabaseReference?
    
    init(title: String, type: String, imageName: String, description: String) {
        self.title = title
        self.type = type
        self.imageName = imageName
        self.description = description
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        type = snapshotValue["type"] as! String
        imageName = snapshotValue["imageName"] as! String
        description = snapshotValue["description"] as! String
        ref = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["title": title, "type": type, "imageName": imageName, "description": description]
    }
}
