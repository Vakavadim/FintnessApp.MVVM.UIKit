//
//  ExercisesViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import UIKit
import Firebase

class ExercisesViewController: UIViewController {
    
    @IBOutlet var addElementButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    var ref: DatabaseReference!
    
    var exercises: [Exercise] = []
    
    var exerciseGroups: [ExerciseTypeRow] = []
    
    private var activityIndicator: UIActivityIndicatorView?
    private var viewModel: ExercisesViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = showActivityIndicator(in: view)
        viewModel = ExercisesViewModel()
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        ref = Database.database().reference(withPath: "workouts").child("exercises")
        setupTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.ref.observe(.value, with: {[weak self] (snapshot) in
            
            var armExercises: [Exercise] = []
            var legExercises: [Exercise] = []
            var shoulderExercises: [Exercise] = []
            var chestExercises: [Exercise] = []
            var backExercises: [Exercise] = []
            var absExercises: [Exercise] = []
            var stretching: [Exercise] = []
            var cardio: [Exercise] = []
            
            for item in snapshot.children {
                let exercise = Exercise(snapshot: item as! DataSnapshot)
                
                switch exercise.type {
                case "armExercise":
                    armExercises.append(exercise)
                case "legExercise":
                    legExercises.append(exercise)
                case "shoulderExercise":
                    shoulderExercises.append(exercise)
                case "chestExercise":
                    chestExercises.append(exercise)
                case "backExercise":
                    backExercises.append(exercise)
                case "absExercise":
                    absExercises.append(exercise)
                case "stretching":
                    stretching.append(exercise)
                case "cardio":
                    cardio.append(exercise)
                default:
                    print("default")
                }
            }
            
            let _exerciseGroups = [
                ExerciseTypeRow(title: "Руки",
                                imageName: "questionmark.circle",
                                exercise: armExercises),
                ExerciseTypeRow(title: "Ноги",
                                imageName: "questionmark.circle",
                                exercise: legExercises),
                ExerciseTypeRow(title: "Плечи",
                                imageName: "questionmark.circle",
                                exercise: shoulderExercises),
                ExerciseTypeRow(title: "Грудь",
                                imageName: "questionmark.circle",
                                exercise: chestExercises),
                ExerciseTypeRow(title: "Спина",
                                imageName: "questionmark.circle",
                                exercise: backExercises),
                ExerciseTypeRow(title: "Пресс",
                                imageName: "questionmark.circle",
                                exercise: absExercises),
                ExerciseTypeRow(title: "Растяжка",
                                imageName: "questionmark.circle",
                                exercise: stretching),
                ExerciseTypeRow(title: "Кардио",
                                imageName: "questionmark.circle",
                                exercise: cardio),
            ]

            self?.exerciseGroups = _exerciseGroups
            self?.activityIndicator?.stopAnimating()
            self?.tableView.reloadData()
        })
    }
    
    @IBAction func addElementAction(_ sender: Any) {
        print("Добавленна активность")
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func setupTableViewCell() {
        let nib = UINib(nibName: "ExerciseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ExerciseCell.reuseId)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            addElementButton.setTitle("Создать упражнение", for: .normal)
            addElementButton.backgroundColor = .systemBlue
        } else if segmentedControl.selectedSegmentIndex == 1 {
            addElementButton.setTitle("Создать программу", for: .normal)
            addElementButton.backgroundColor = .systemIndigo
        }
    }
}

extension ExercisesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exerciseGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        guard let cell = cell as? ExerciseCell else { return UITableViewCell() }
        cell.typeImage.image = UIImage(systemName: exerciseGroups[indexPath.row].imageName)
        cell.titleLabel.text = exerciseGroups[indexPath.row].title
        cell.exerciseCountLabel.text = exerciseGroups[indexPath.row].exercise.count.formatted()

        return cell
    }
}
