//
//  CalendarCell.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 19.10.2022.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet var selectedView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    var viewModel: CalendarCellViewModelProtocol! {
        didSet {
            selectedView.layer.cornerRadius = selectedView.frame.height / 2
            dateLabel.text = viewModel.dayNumber
            dateLabel.textColor = viewModel.currentDayIndicator || viewModel.selectedIndicator ? .white : .black
            selectedView.isHidden = !viewModel.currentDayIndicator && !viewModel.selectedIndicator
            selectedView.backgroundColor = viewModel.selectedIndicator ? .red : .gray
        }
    }
}
