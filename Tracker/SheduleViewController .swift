//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.06.2025.
//

import UIKit

final class SheduleViewController: UIViewController {
    private var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        addTitleLabel()
    }
    
    private func addTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        let titleLabelStrokeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.ypBlack,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        
        titleLabel.attributedText = NSMutableAttributedString(
            string: "Расписание",
            attributes: titleLabelStrokeTextAttributes
        )
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
