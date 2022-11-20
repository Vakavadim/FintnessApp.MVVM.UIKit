//
//  ExercisesViewCell.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 17.11.2022.
//

import UIKit

class ExerciseCell: UITableViewCell {
    
    var viewModel: ExerciseCellViewModelProtocol! {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        var content = defaultContentConfiguration()
        content.text = viewModel.exercise.title
        content.image = UIImage(systemName: viewModel.exercise.imageName)
        contentConfiguration = content
    }
}
