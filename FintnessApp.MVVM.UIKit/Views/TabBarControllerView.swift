//
//  TabBarControllerView.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 10.10.2022.
//

import UIKit
import RealmSwift

class TabBarControllerView: UITabBarController {
    
    private let workoutVC: WorkoutViewController = WorkoutViewController.loadFromStoryboard()
    private let exercisesVC: ExercisesViewController = ExercisesViewController.loadFromStoryboard()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(rgb: 0xFF564C)
        view.backgroundColor = .red
        
        setTabs(
            viewController: workoutVC,
            image: UIImage(systemName: "list.bullet.circle"),
            title: "Workout"
        )
        setTabs(
            viewController: exercisesVC,
            image: UIImage(systemName: "list.bullet.circle"),
            title: "Exercises")
        viewControllers = [workoutVC, exercisesVC]
        
    }
    
    private func setTabs(viewController: UIViewController, image: UIImage?, title: String) -> () {
        guard let image = image else { return }
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
