//
//  ExerciseCell.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 04.11.2022.
//

import UIKit

class ExerciseCell: UITableViewCell {
    @IBOutlet var typeImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var exerciseCountLabel: UILabel!
    
    
    static let reuseId = "ExerciseCell"
    
    var viewModel: ExerciseCellViewModelProtocol! {
        didSet {
            
        }
    }
}
