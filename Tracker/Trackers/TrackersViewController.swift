//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.05.2025.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    //MARK: UI elements
    
    private var largeTitleLabel = UILabel()
    private var plusButton = UIButton()
    private var datePicker = UIDatePicker()
//    private var trackers = UICollectionView()
    
    //MARK: Services
    
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    private let newHabitViewController = NewHabitViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        
        addLargeTitleLabel()
        addPlusButton()
        addDatePicker()
    }
    
    private func addLargeTitleLabel() {
        largeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(largeTitleLabel)
        let largeTitleLabelStrokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.ypBlack,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 34),
        ]
        
        largeTitleLabel.attributedText = NSMutableAttributedString(
            string: "Трекеры",
            attributes: largeTitleLabelStrokeTextAttributes)
        
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: plusButton)
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
        newHabitViewController.modalPresentationStyle = .pageSheet
        self.present(newHabitViewController, animated: true)
    }
    
    private func addDatePicker() {
        view.addSubview(datePicker)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        let currentDate = Date()
        let calendar = Calendar.current
        let minDate = calendar.date(byAdding: .year, value: -10, to: currentDate)
        let maxDate = calendar.date(byAdding: .year, value: 10, to: currentDate)
        datePicker.tintColor = .ypBlue
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: 34),
            datePicker.widthAnchor.constraint(equalToConstant: 77),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)
        ])
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Выбранная дата: \(formattedDate)")
    }
}
