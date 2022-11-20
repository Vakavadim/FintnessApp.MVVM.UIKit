//
//  ExercisesViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 15.11.2022.
//

import UIKit
import RealmSwift

class ExercisesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel: ExercisesViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "ExerciseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ExerciseCell")
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ExercisesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.getCellViewModel(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        guard let cell = cell as? ExerciseCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertForAddExercise(indexPath: indexPath)
    }
}

// MARK: - Alert for add workouts
extension ExercisesViewController {
    func alertForAddExercise(indexPath: IndexPath) {
        
        
        let cellViewModel = viewModel.getCellViewModel(indexPath: indexPath)
        let title = cellViewModel.exercise.title
        let type = cellViewModel.exercise.type
        let description = cellViewModel.exercise.description
        let imageName = cellViewModel.exercise.imageName
        
        let workout = Workout()
        workout.name = title
        workout.type = type
        workout.imageName = imageName
        let selectedDate = UDDateManager.shared.getSelectedDate()
        
        let workoutLists = StorageManager.shared.realm.objects(WorkoutList.self).where {
            $0.date == selectedDate
        }
        
        
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add", style: .default) { _ in
            print("Save action")
            if workoutLists.first != nil {
                StorageManager.shared.saveWorkout(workout, for: workoutLists.first!)
            } else {
                let workoutList = WorkoutList()
                workoutList.date = selectedDate
                workoutList.listName = "workoutList"
                workoutList.weight = 90.0
                workoutList.workouts.append(workout)
                StorageManager.shared.saveWorkoutList(workoutList)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
}
