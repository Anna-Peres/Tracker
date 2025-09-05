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
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: Services
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    private let newHabitViewController = NewHabitViewController()
    private var filteredCategories: [TrackerCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setupUI()
        setupGestureRecognizer()
    }
    
    private func setupUI() {
        addLargeTitleLabel()
        addPlusButton()
        addDatePicker()
        addSearchBar()
        updateCollectonView()
    }
    
    private func addLargeTitleLabel() {
        largeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(largeTitleLabel)
        let largeTitleLabelStrokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.ypBlack,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 34, weight: .bold),
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
            stubLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 48),
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didTapPlusButton() {
        newHabitViewController.modalPresentationStyle = .pageSheet
        newHabitViewController.clearFields()
        self.present(newHabitViewController, animated: true)
        newHabitViewController.onSave = { [weak self] tracker, categoryTitle in
            self?.addTracker(tracker, toCategory: categoryTitle)
        }
        updateCollectonView()
    }
    
    private func addTracker(_ tracker: Tracker, toCategory categoryTitle: String) {
        let updatedCategories: [TrackerCategory]
        
        if let existingCategoryIndex = categories.firstIndex(where: { $0.title == categoryTitle }) {
            let existingCategory = categories[existingCategoryIndex]
            let updatedTrackers = existingCategory.trackers + [tracker]
            let updatedCategory = TrackerCategory(
                title: existingCategory.title,
                trackers: updatedTrackers
            )
            
            updatedCategories = categories.enumerated().map { index, category in
                index == existingCategoryIndex ? updatedCategory : category
            }
        } else {
            let newCategory = TrackerCategory(
                title: categoryTitle,
                trackers: [tracker]
            )
            updatedCategories = categories + [newCategory]
        }
        
        categories = updatedCategories
        updateCollectonView()
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
        datePicker.locale = Locale(identifier: "ru_RU")
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
        updateCollectonView()
    }
    
    private func addSearchBar() {
        view.addSubview(searchBar.searchTextField)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск"
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
        collectionView.reloadData()
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
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: "Tracker cell")
        collectionView.register(TrackerSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    private func updateCollectonView() {
        filterTrackers()
        let hasData = filteredCategories.contains { !$0.trackers.isEmpty }
        if hasData {
            stubImageView.removeFromSuperview()
            stubLabel.removeFromSuperview()
            addCollectionView()
        } else {
            collectionView.removeFromSuperview()
            addStubImage()
            addStubLabel()
        }
    }
    
    private func filterTrackers() {
        let selectedDate = datePicker.date
        let weekday = Calendar.current.component(.weekday, from: selectedDate)
        
        var dateFilteredCategories = categories.map { category in
            let filteredTrackers = category.trackers.filter { tracker in
                tracker.schedule.contains { $0.rawValue == weekday }
            }
            return TrackerCategory(title: category.title, trackers: filteredTrackers)
        }
        filteredCategories = dateFilteredCategories
    }
    
    private func completeTracker(with id: UUID) {
        let selectedDate = datePicker.date
        let today = Date()
        
        if selectedDate > today {
            return
        }
        
        let record = TrackerRecord(id: id, date: selectedDate)
        completedTrackers.append(record)
        updateCollectonView()
    }
    
    private func uncompleteTracker(with id: UUID) {
        let selectedDate = datePicker.date
        completedTrackers.removeAll {
            $0.id == id && Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
        updateCollectonView()
    }
    
    private func isTrackerCompletedToday(_ id: UUID) -> Bool {
        let selectedDate = datePicker.date
        return completedTrackers.contains {
            $0.id == id && Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    private func getCompletionCount(for trackerId: UUID) -> Int {
        return completedTrackers.filter { $0.id == trackerId }.count
    }
    
    private func handleTrackerCompletion(_ trackerId: UUID, _ isCompleted: Bool) {
        if isCompleted {
            completeTracker(with: trackerId)
        } else {
            uncompleteTracker(with: trackerId)
        }
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filteredCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCategories[section].trackers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Tracker cell",
            for: indexPath
        ) as? TrackerCell else {
            return UICollectionViewCell()
        }
        
        let tracker = filteredCategories[indexPath.section].trackers[indexPath.item]
        let isCompleted = isTrackerCompletedToday(tracker.id)
        let completionCount = getCompletionCount(for: tracker.id)
        
        cell.configure(
            with: tracker,
            isCompletedToday: isCompleted,
            completionCount: completionCount
        ) { [weak self] trackerId, isCompleted in
            self?.handleTrackerCompletion(trackerId, isCompleted)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "Header"
        default:
            id = ""
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! TrackerSupplementaryView
        view.titleLabel.text = filteredCategories[indexPath.section].title
        return view
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableWidth = max(0, collectionView.frame.width - 16)
        let cellWidth = availableWidth / 2
        return CGSize(width: max(0, cellWidth), height: max(0, 148))
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 30)
       }
}
