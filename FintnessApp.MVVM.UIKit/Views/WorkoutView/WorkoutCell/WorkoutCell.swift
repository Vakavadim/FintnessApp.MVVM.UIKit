//
//  WorkoutCell.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 12.10.2022.
//

import UIKit

class WorkoutCell: UITableViewCell {
    
    static let reuseId = "workoutCell"
    
    var viewModel: WorkoutCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.workoutName
            content.image = UIImage(systemName: viewModel.imageName)
            content.imageProperties.tintColor = UIColor(rgb: 0xFF564C)
            contentConfiguration = content
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
