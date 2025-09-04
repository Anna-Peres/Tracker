//
//  SсheduleViewController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.06.2025.
//

import UIKit

final class SсheduleViewController: UIViewController {
    //MARK: UI elements
    private var titleLabel = UILabel()
    private var tableView = UITableView()
    private var doneButton = UIButton()
    
    //MARK: Services
    var selectedDays: [Weekday] = []
    var onDaysSelected: (([Weekday]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        addTitleLabel()
        addTableView()
        addDoneButton()
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
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 16
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 525),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func addDoneButton() {
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Готово", for: .normal)
        doneButton.setTitleColor(.ypWhite, for: .normal)
        doneButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        doneButton.backgroundColor = .ypBlack
        doneButton.layer.cornerRadius = 16
        doneButton.addTarget(self, action: #selector (didTapDoneButton), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    @objc private func didTapDoneButton() {
        onDaysSelected?(selectedDays)
        self.dismiss(animated: true)
    }
}

extension SсheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScheduleCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Schedule cell") {
            cell = reusedCell as! ScheduleCell
        } else {
            cell = ScheduleCell(style: .default, reuseIdentifier: "Schedule cell")
        }
        cell.accessoryType = .none
        cell.backgroundColor = .background
        cell.heightAnchor.constraint(equalToConstant: 75).isActive = true
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let weekday = Weekday.allCases[indexPath.row]
        let isSelected = selectedDays.contains(weekday)
        
        cell.configure(with: weekday.name, isOn: isSelected)
        cell.onSwitchChanged = { [weak self] isOn in
            if isOn {
                self?.selectedDays.append(weekday)
            } else {
                self?.selectedDays.removeAll { $0 == weekday }
            }
        }
        return cell
    }
}

extension SсheduleViewController: UITableViewDelegate {
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
