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
    private var searchBar = UISearchBar()
    private var stubImageView = UIImageView()
    private var stubLabel = UILabel()
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.register(TrackerCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
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
        addSearchBar()
        addCollectionView()
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
    
    private func addStubImage() {
        guard let stubImage = UIImage(named: "Stub_image") else { return }
        stubImageView = UIImageView(image: stubImage)
        view.addSubview(stubImageView)
        stubImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stubImageView.heightAnchor.constraint(equalToConstant: 80),
            stubImageView.widthAnchor.constraint(equalToConstant: 80),
            stubImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addStubLabel() {
        stubLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stubLabel)
        let stubLabelStrokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.ypBlack,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .medium),
        ]
        
        stubLabel.attributedText = NSMutableAttributedString(
            string: "Что будем отслеживать?",
            attributes: stubLabelStrokeTextAttributes)
        
        NSLayoutConstraint.activate([
            stubLabel.topAnchor.constraint(equalTo: stubImageView.bottomAnchor, constant: 8),
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    private func addSearchBar() {
        view.addSubview(searchBar.searchTextField)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .background
        searchBar.searchTextField.layer.cornerRadius = 16
        NSLayoutConstraint.activate([
            searchBar.searchTextField.heightAnchor.constraint(equalToConstant: 36),
            searchBar.searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 92),
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func addCollectionView() {
        if completedTrackers.count > 0 {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(collectionView)
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 162),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ])
            
            collectionView.dataSource = self
            collectionView.delegate = self
        } else {
            addStubImage()
            addStubLabel()
        }
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return completedTrackers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TrackerCollectionViewCell
        
//        cell.titleLabel.text = completedTrackers[indexPath.row]
        return cell
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 148)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}
