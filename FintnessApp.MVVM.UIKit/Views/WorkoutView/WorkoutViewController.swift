//
//  WorkoutViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 10.10.2022.
//

import UIKit

protocol WorkoutViewControllerDelegate: AnyObject {
    func changeCalendarSize(state: Bool)
    func reloadTableViewData()
}

class WorkoutViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightStepper: UIStepper!
    
    private var calendarVC: CalendarViewController!
    private var visualEffectView: UIVisualEffectView!
    
    private let calendarVCMin = CGRect(x: 0,
                                       y: -200,
                                       width: UIScreen.main.bounds.width,
                                       height: 400)
    private let calendarVCMax = CGRect(x: 0,
                                       y: 0,
                                       width: UIScreen.main.bounds.width,
                                       height: 400)
    
    private var viewModel: WorkoutViewModelProtocol! {
        didSet {
            viewModel.getWorkouts()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WorkoutViewModel()
        setupTabBar()
        setupTableViewCell()
        setupCalendarView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadTableViewData()
    }
    
    
    @IBAction func weightStepper(_ sender: UIStepper) {
        sender.stepValue = 0.5
        weightLabel.text = String(sender.value)
    }
    
    private func setupTableViewCell() {
        let nib = UINib(nibName: "WorkoutCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: WorkoutCell.reuseId)
    }
    
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func installVisualEffect() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.insertSubview(visualEffectView,
                                belowSubview: self.calendarVC.view)
    }
    
    private func setupCalendarView() {
        calendarVC = CalendarViewController(
            nibName: "CalendarViewController",
            bundle: nil
        )
        
        self.addChild(calendarVC)
        self.view.addSubview(calendarVC.view)
        
        calendarVC.view.frame = calendarVCMin
        calendarVC.delegate = self
    }
    
    private func setupUI() {
        tableView.layer.cornerRadius = 20
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.clipsToBounds = true
        weightLabel.text = viewModel.getLastWeight().formatted()
        weightStepper.value = viewModel.getLastWeight()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

// MARK: - WorkoutViewControllerDelegate
extension WorkoutViewController: WorkoutViewControllerDelegate {
    func reloadTableViewData() {
        viewModel.getWorkouts()
        tableView.reloadData()
    }
    
    func changeCalendarSize(state: Bool) {
        self.calendarVC.view.frame = state ? calendarVCMax : calendarVCMin
        
        if state {
            // work with visualEffectView
            installVisualEffect()
            self.visualEffectView.effect = UIBlurEffect(style: .dark)
            self.visualEffectView.alpha = 0.8
        } else {
            // work with visualEffectView
            self.visualEffectView.effect = nil
            self.visualEffectView.removeFromSuperview()
        }
    }
    
    
}
