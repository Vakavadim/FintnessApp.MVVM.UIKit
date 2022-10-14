//
//  WorkoutViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 10.10.2022.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    private var viewModel: WorkoutViewModelProtocol! {
        didSet {
            viewModel.getWorkouts()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WorkoutViewModel()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WorkoutCell")
        setupTabBar()
        // Do any additional setup after loading the view.
    }
    
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        guard let cell = cell as? WorkoutCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getWorkoutCellViewModel(at: indexPath)
        return cell
        
    }
}
