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
    //    private let buttons = ["Категория", "Расписание"]
    private let scheduleViewController = ScheduleViewController()
    private var selectedDays: [Weekday] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        addTitleLabel()
        addTextField()
        addTableView()
        addCancelButton()
        addCreateButton()
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
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapCreateButton () {
        guard let name = textField.text, !name.isEmpty else { return }
        
        let newTracker = Tracker(
            name: name,
            color: .selection5,
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
        let cell: NewHabitCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "New habit cell") {
            cell = reusedCell as! NewHabitCell
        } else {
            cell = NewHabitCell(style: .default, reuseIdentifier: "New habit cell")
        }
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
