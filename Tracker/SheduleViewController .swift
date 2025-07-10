//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.06.2025.
//

import UIKit

final class SheduleViewController: UIViewController {
    private var titleLabel = UILabel()
    private var tableView = UITableView()
    private var doneButton = UIButton()
    
    private let days = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
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
    
    @objc private func didTapDoneButton () {
        
    }
}

extension SheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = days[indexPath.row]
        cell.textLabel?.textColor = .ypBlack
        cell.textLabel?.font = .systemFont(ofSize: 17)
        cell.accessoryType = .none
        cell.backgroundColor = .background
        cell.heightAnchor.constraint(equalToConstant: 75).isActive = true
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        guard let window = view.window else { return cell }
        let rowX = window.frame.width - 99
        let groupSwitch = UISwitch(frame: CGRect(x: rowX, y: 22, width: 51, height: 31))
        groupSwitch.isEnabled = true
        groupSwitch.isUserInteractionEnabled = true
        cell.addSubview(groupSwitch)
        return cell
    }
}

extension SheduleViewController: UITableViewDelegate {
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
