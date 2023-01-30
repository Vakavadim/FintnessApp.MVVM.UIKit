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
    weak var delegate: WorkoutViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CalendarViewModel()
        registerCalendarCell()
        updateCollectionViewSize()
        setupUI()
    }
    
    @IBAction func expendButton(_ sender: Any) {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,
//                       initialSpringVelocity: 1,
//                       options: .curveEaseOut,
//                       animations: { [unowned self] in
//            delegate?.changeCalendarSize(state: viewModel.calendarExpand)
//            viewModel.calendarChangeSize(state: !viewModel.calendarExpand)
//            self.view.layoutIfNeeded()
//        }, completion: nil)

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
        
        UDDateManager.shared.unsetSelectedDate()
        viewModel.viewModelDidChange = { [unowned self] viewModel in
            calendarCollectionView.reloadData()
            updateCollectionViewSize()
            dataLabel.text = viewModel.dateString
        }
    }
    
    private func updateCollectionViewSize() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            let height = self.calendarCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.calendarViewHeight.constant = height
            self.view.setNeedsLayout()
            }, completion: nil)
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
            print("unknown handle pan")
        }
    }
    
    private func handlePanChange(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view.superview)
        self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
        
        self.delegate?.installVisualEffectView()
        let newAlpha = translation.y / 100
        self.delegate?.changeVisualEffectViewAlpha(alpha: newAlpha)
    }
    
    private func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view.superview)
        let velocity = gesture.velocity(in: self.view.superview)
        
        
        
        print("handlePanEnded")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.view.transform = .identity

            if translation.y > 100 || velocity.y > 500 {
                self.view.transform = .identity
                print("handlePanEnded")
                // change alpha
                self.delegate?.changeCalendarSize(state: false)
                self.viewModel.calendarChangeSize(state: true)
            } else {
                // deinstall effect
                self.delegate?.uninstallVisualEffectView()
                self.delegate?.changeCalendarSize(state: true)
                self.viewModel.calendarChangeSize(state: false)
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
        delegate?.reloadTableViewData()
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

