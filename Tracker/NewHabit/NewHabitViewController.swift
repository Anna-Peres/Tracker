//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.06.2025.
//

import UIKit

final class NewHabitViewController: UIViewController {
    //MARK: UI elements
    private var titleLabel = UILabel()
    private var textField = UITextField()
    private var tableView = UITableView()
    private lazy var containerStackView = UIStackView()
    private var cancelButton = UIButton()
    private var createButton = UIButton()
    
    //MARK: Services
    var onSave: ((Tracker, String) -> Void)?
    private let scheduleViewController = ScheduleViewController()
    private var selectedDays: [Weekday] = []
    private let emojies = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    private var colors = [
        UIColor(named: "Color selection 1"),
        UIColor(named: "Color selection 2"),
        UIColor(named: "Color selection 3"),
        UIColor(named: "Color selection 4"),
        UIColor(named: "Color selection 5"),
        UIColor(named: "Color selection 6"),
        UIColor(named: "Color selection 7"),
        UIColor(named: "Color selection 8"),
        UIColor(named: "Color selection 9"),
        UIColor(named: "Color selection 10"),
        UIColor(named: "Color selection 11"),
        UIColor(named: "Color selection 12"),
        UIColor(named: "Color selection 13"),
        UIColor(named: "Color selection 14"),
        UIColor(named: "Color selection 15"),
        UIColor(named: "Color selection 16"),
        UIColor(named: "Color selection 17"),
        UIColor(named: "Color selection 18")
    ]
    
    private var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        setupUI()
        setupGestureRecognizer()
        tableView.register(NewHabitCell.self, forCellReuseIdentifier: "New habit cell")
    }
    
    func clearFields() {
        textField.text = nil
        updateCreateButton()
        selectedDays = []
        scheduleViewController.tableView.reloadData()
        tableView.reloadData()
    }
    
    private func setupUI() {
        addTitleLabel()
        addTextField()
        addTableView()
        addCancelButton()
        addCreateButton()
        addCollectionView()
    }
    
    private func addTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        let titleLabelStrokeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.ypBlack,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        
        titleLabel.attributedText = NSMutableAttributedString(
            string: "Новая привычка",
            attributes: titleLabelStrokeTextAttributes
        )
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func addTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название трекера"
        textField.backgroundColor = .background
        textField.layer.cornerRadius = 16
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(textFieldСhanged), for: .editingChanged)
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 75),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 87),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 16
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 150),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 186),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func addCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.ypRed, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        cancelButton.layer.borderColor = UIColor.ypRed.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 16
        cancelButton.addTarget(self, action: #selector (didTapCancelButton), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 852),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -4)
        ])
    }
    
    @objc private func didTapCancelButton () {
        self.dismiss(animated: true)
    }
    
    private func addCreateButton() {
        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Создать", for: .normal)
        createButton.setTitleColor(.ypWhite, for: .normal)
        createButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        createButton.backgroundColor = .ypGray
        createButton.layer.cornerRadius = 16
        createButton.addTarget(self, action: #selector (didTapCreateButton), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 852),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 4)
        ])
    }
    
    private func updateCreateButton() {
        let isTitleValid = !(textField.text?.isEmpty ?? true)
        let isScheduleSelected = !selectedDays.isEmpty
        
        createButton.isEnabled = isTitleValid && isScheduleSelected
        createButton.backgroundColor = createButton.isEnabled ? UIColor(resource: .ypBlack) : UIColor(resource: .ypGray)
    }
    
    @objc private func textFieldСhanged(_ textField: UITextField) {
        if let text = textField.text, text.count > 38 {
            textField.text = String(text.prefix(38))
        }
        updateCreateButton()
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func addCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 336),
            collectionView.heightAnchor.constraint(equalToConstant: 476),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
        ])

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OptionsCell.self, forCellWithReuseIdentifier: "Options cell")
        collectionView.register(OptionsSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapCreateButton () {
        guard let name = textField.text, !name.isEmpty else { return }
        
        let newTracker = Tracker(
            id: UUID(),
            name: name,
            color: .colorSelection5,
            emoji: "😪",
            schedule: selectedDays
        )
        
        onSave?(newTracker, "Важное")
        dismiss(animated: true)
    }
}

extension NewHabitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "New habit cell") as! NewHabitCell
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .background
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Категория"
        } else {
            let weekdaysText = selectedDays.isEmpty ? nil : selectedDays.map { $0.shortName }.joined(separator: ", ")
            cell.configure(title: "Расписание", subtitle: weekdaysText)
        }
        
        return cell
    }
}

extension NewHabitViewController: UITableViewDelegate {
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let indexPath = indexPath.row
        if indexPath == 0 {
            
        } else {
            scheduleViewController.modalPresentationStyle = .pageSheet
            self.present(scheduleViewController, animated: true)
            scheduleViewController.selectedDays = selectedDays
            scheduleViewController.onDaysSelected = { [weak self] weekdays in
                self?.selectedDays = weekdays
                tableView.reloadData()
                self?.updateCreateButton()
            }
        }
    }
}

extension NewHabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateCreateButton()
    }
}

extension NewHabitViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        18
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Options cell", for: indexPath) as! OptionsCell
        if indexPath.section == 0 {
            cell.emojiLabel.text = emojies[indexPath.row]
        } else {
            cell.colorView.backgroundColor = colors[indexPath.row]
        }
        cell.layer.cornerRadius = 16
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
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! OptionsSupplementaryView
        if indexPath.section == 0 {
            view.titleLabel.text = "Emoji"
        } else {
            view.titleLabel.text = "Цвет"
        }
        return view
    }
}

extension NewHabitViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? OptionsCell
        if indexPath.section == 0 {
            cell?.backgroundColor = .background
        } else {
            cell?.makeFramed(cellColor: (cell?.colorView.backgroundColor) ?? .background)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? OptionsCell
        if indexPath.section == 0 {
            cell?.backgroundColor = nil
        } else {
            cell?.deleteFrame()
        }
    }
}

extension NewHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 52, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 82)
       }
}
