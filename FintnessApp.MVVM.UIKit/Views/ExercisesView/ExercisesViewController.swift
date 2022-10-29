//
//  ExercisesViewController.swift
//  FintnessApp.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 13.10.2022.
//

import UIKit

class ExercisesViewController: UIViewController {
    
    @IBOutlet var addElementButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            addElementButton.titleLabel?.text = "Создать активность"
            addElementButton.backgroundColor = .systemBlue
        } else if segmentedControl.selectedSegmentIndex == 1 {
            addElementButton.titleLabel?.text = "Создать программу"
            addElementButton.backgroundColor = .systemIndigo
        }
    }
}

//extension ExercisesViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//}
