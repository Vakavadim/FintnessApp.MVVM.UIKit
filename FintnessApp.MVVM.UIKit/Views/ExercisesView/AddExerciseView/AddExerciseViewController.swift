//
//  AddExerciseViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.01.2023.
//

import UIKit

class AddExerciseViewController: UIViewController {
    
    var viewModel: AddExerciseViewModelProtocol!
    
    @IBOutlet weak var regularDataStack: UIStackView!
    @IBOutlet weak var cardioDataStack: UIStackView!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var exerciseDescription: UILabel!
    @IBOutlet weak var setsCount: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var range: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        if viewModel.exerciseType == "cardio" {
            regularDataStack.isHidden = true
        } else {
            cardioDataStack.isHidden = true
        }
        
        exerciseTitle.text = viewModel.exerciseTitle
        exerciseDescription.text = viewModel.exerciseDescription
        exerciseImage.image = viewModel.exerciseImage
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func addButton(_ sender: Any) {
        viewModel.addExercise(setsCount: setsCount.text,
                              weight: weight.text,
                              time: time.text,
                              range: range.text)
        dismiss(animated: true)
    }
}
