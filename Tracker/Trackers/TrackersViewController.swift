//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.05.2025.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    private var largeTitleLabel = UILabel()
    private var plusButton = UIButton()
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        
        addLargeTitleLabel()
        addPlusButton()
    }
    
    private func addLargeTitleLabel() {
        print("Заголовок")
        largeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(largeTitleLabel)
        let largeTitleLabelStrokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.ypBlack,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 34),
        ]
        
        largeTitleLabel.attributedText = NSMutableAttributedString(string: "Трекеры", attributes: largeTitleLabelStrokeTextAttributes)
        
        NSLayoutConstraint.activate([
            largeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            largeTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    private func addPlusButton() {
        guard let plusImage = UIImage(named: "Plus_button") else { return }
        plusButton = UIButton.systemButton(
            with: plusImage,
            target: self,
            action: #selector(Self.didTapPlusButton)
        )
        view.addSubview(plusButton)
        plusButton.tintColor = .ypBlack
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.heightAnchor.constraint(equalToConstant: 18),
            plusButton.widthAnchor.constraint(equalToConstant: 19),
            plusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13)
        ])
    }
    
    @objc private func didTapPlusButton() {

    }
}
