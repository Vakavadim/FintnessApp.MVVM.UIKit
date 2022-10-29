//
//  CalendarViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet var calendarViewHeight: NSLayoutConstraint!
    @IBOutlet var dataLabel: UILabel!
    
    private var viewModel: CalendarViewModelProrocol!
    
    // External dependencies
    weak var delgate: WorkoutViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CalendarViewModel()
        registerCalendarCell()
        updateCollectionViewSize()
        setupUI()
    }
    
    @IBAction func expendButton(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [self] in
            viewModel.calendarChangeSize()
            delgate?.changeCalendarSize(state: viewModel.calendarExpand)
        }, completion: nil)

        print("Button did tap")
    }
    
    private func registerCalendarCell() {
        let nib = UINib(nibName: "CalendarCell", bundle: nil)
        calendarCollectionView.register(nib, forCellWithReuseIdentifier: "CalendarCell")
    }
    
    private func setupUI() {
        self.view.addGestureRecognizer(
            UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)
            )
        )
        self.view.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action: #selector(handleDismissalPan)
            )
        )
        UDDateManager.shared.unsetSelectedDate()
        viewModel.viewModelDidChange = { [unowned self] viewModel in
            calendarCollectionView.reloadData()
            updateCollectionViewSize()
            dataLabel.text = viewModel.dateString
            print("View model did change")
        }
    }
    
    private func updateCollectionViewSize() {
        DispatchQueue.main.async {
            let height = self.calendarCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.calendarViewHeight.constant = height
            self.view.setNeedsLayout()
        }
    }
    
// MARK: - Gesters
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .changed:
            handlePanChange(gesture: gesture)
        case .ended:
            handlePanEnded(gesture: gesture)
        default:
            print("unknown default")
        }
    }
    
    @objc private func handleDismissalPan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleDismissalPanChange(gesture: gesture)
        case .ended:
            handleDismissalPanEnded(gesture: gesture)
        default:
            print("unknown default")
        }
    }
    
    private func handlePanChange(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view.superview)
        self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
    }
    
    private func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view.superview)
        let velocity = gesture.velocity(in: self.view.superview)
        self.view.transform = .identity
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [self] in
        if translation.y > 100 || velocity.y > 500 {
                viewModel.calendarChangeSize()
                delgate?.changeCalendarSize(state: viewModel.calendarExpand)
            }
        }, completion: nil)
    }
    
    private func handleDismissalPanChange(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view.superview)
        self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
    }
    
    private func handleDismissalPanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view.superview)
        let velocity = gesture.velocity(in: self.view.superview)
        self.view.transform = .identity
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [self] in
            if translation.y > -100 || velocity.y > -500 {
                viewModel.calendarChangeSize()
                delgate?.changeCalendarSize(state: viewModel.calendarExpand)
            }
        }, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCalendarItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath)
        guard let cell = cell as? CalendarCell else { return UICollectionViewCell() }
        
        cell.viewModel = viewModel.getCalendarCellViewModel(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellDidSelected(at: indexPath)
        print(viewModel.selectedDate)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 9
//        let paddingWidth = 1 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}

