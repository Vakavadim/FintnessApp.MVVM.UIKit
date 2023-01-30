//
//  WorkoutViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 10.10.2022.
//

import UIKit

protocol WorkoutViewControllerDelegate: AnyObject {
    func changeCalendarSize(state: Bool)
    func installVisualEffectView()
    func uninstallVisualEffectView()
    func changeVisualEffectViewAlpha(alpha: Double)
    func reloadTableViewData()
}

class WorkoutViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightStepper: UIStepper!
    
    private var calendarVC: CalendarViewController!
    private var minimizedTopAnchorConstarins: NSLayoutConstraint!
    private var maximazedTopAnchorConstarins: NSLayoutConstraint!
    private var bottomAnchorConstarins: NSLayoutConstraint!
    private var visualEffectView: UIVisualEffectView!
    private var timer: Timer?
    
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
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.viewModel.setWeightValue(weigth: sender.value)
        })
        
    }
    
    // MARK: - Setup UI
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
    
    private func setupCalendarView() {
        calendarVC = CalendarViewController(
            nibName: "CalendarViewController",
            bundle: nil
        )
        
        self.addChild(calendarVC)
        self.view.addSubview(calendarVC.view)
        
        calendarVC.view.translatesAutoresizingMaskIntoConstraints = false
        maximazedTopAnchorConstarins = calendarVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.height)
        minimizedTopAnchorConstarins = calendarVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: -view.frame.height)
        bottomAnchorConstarins = calendarVC.view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        
        calendarVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        calendarVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        minimizedTopAnchorConstarins.isActive = true
        bottomAnchorConstarins.isActive = true
        
        calendarVC.delegate = self
    }
    
    private func setCalendarMinimalSize() {
        bottomAnchorConstarins.constant = 200
        maximazedTopAnchorConstarins.isActive = false
        minimizedTopAnchorConstarins.isActive = true
    }
    
    private func setCalendarMaximumSize() {
        bottomAnchorConstarins.constant = 400
        maximazedTopAnchorConstarins.isActive = true
        minimizedTopAnchorConstarins.isActive = false
    }
    
    
    
    private func setupUI() {
        tableView.layer.cornerRadius = 20
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.clipsToBounds = true
        weightLabel.text = viewModel.getWeightValue().formatted()
        weightStepper.value = viewModel.getWeightValue()
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
    
    func installVisualEffectView() {
        if self.visualEffectView == nil {
            self.visualEffectView = UIVisualEffectView()
            self.visualEffectView.frame = self.view.frame
            self.view.insertSubview(
                visualEffectView,
                belowSubview: self.calendarVC.view
            )
            self.visualEffectView.effect = UIBlurEffect(style: .dark)
            self.visualEffectView.alpha = 0.0
        }
    }
    
    func uninstallVisualEffectView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            DispatchQueue.main.async {
                self.visualEffectView.removeFromSuperview()
                self.visualEffectView = nil
            }
        }, completion: nil)
    }
    
    func changeVisualEffectViewAlpha(alpha: Double) {
        self.visualEffectView.alpha = alpha
    }
    
    func reloadTableViewData() {
        viewModel.getWorkouts()
        setupUI()
        tableView.reloadData()
    }
    
    func changeCalendarSize(state: Bool) {
        state ? setCalendarMinimalSize() : setCalendarMaximumSize()
    }
    
    
}
