//
//  ExercisesGroupViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import UIKit

class ExercisesGroupViewController: UIViewController {
    
    @IBOutlet var addElementButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView?
    private var viewModel: ExercisesGroupViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ExercisesGroupViewModel()
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        setupUI()
    }
    
    @IBAction func addElementAction(_ sender: Any) {
        print(viewModel.rows.count)
        tableView.reloadData()
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
    
    private func setupUI() {
        registerTableViewCell()
        viewModel.getRows()
        activityIndicator = showActivityIndicator(in: view)
        viewModel.viewModelDidChange = { [unowned self] viewModel in
            tableView.reloadData()
            activityIndicator?.stopAnimating()
        }
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "ExerciseGroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ExerciseGroupCell")
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
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let exercisesVC = segue.destination as? ExercisesViewController else {
            return
        }
        exercisesVC.viewModel = sender as? ExercisesViewModelProtocol
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ExercisesGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseGroupCell", for: indexPath)
        guard let cell = cell as? ExerciseGroupCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellViewModel = viewModel.rows[indexPath.row]
        let corseDetailsViewModel = ExercisesViewModel(exercise: cellViewModel.exercises)
        performSegue(withIdentifier: "showExercises", sender: corseDetailsViewModel)
    }
}
