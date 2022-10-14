//
//  WorkoutCell.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 12.10.2022.
//

import UIKit

class WorkoutCell: UITableViewCell {
    
    static let reuseId = "WorkoutCell"
    var viewModel: WorkoutCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.imageName
            content.image = UIImage(systemName: viewModel.imageName)
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
