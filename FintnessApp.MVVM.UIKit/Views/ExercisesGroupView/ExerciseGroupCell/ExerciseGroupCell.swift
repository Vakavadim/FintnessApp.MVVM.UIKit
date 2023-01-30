//
//  ExerciseCell.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 04.11.2022.
//

import UIKit

class ExerciseGroupCell: UITableViewCell {
    @IBOutlet var typeImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var exerciseCountLabel: UILabel!
    
    var viewModel: ExerciseGroupCellViewModelProtocol! {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        typeImage.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.exerciseGroupName
        exerciseCountLabel.text = viewModel.exercises.count.formatted()
    }
}
