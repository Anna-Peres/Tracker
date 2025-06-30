//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Анна Перескокова on 24.06.2025.
//

import UIKit

final class NewHabitViewController: UIViewController {
    private var titleLabel = UILabel()
    private var textField = UITextField()
    private var categoryButton = UIButton()
    private var sheduleButton = UIButton()
    private var cancelButton = UIButton()
    private var createButton = UIButton()
    
    private let sheduleViewController = SheduleViewController()
    private let trackersViewController = TrackersViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        addTitleLabel()
        addTextField()
        addCategoryButton()
        addSheduleButton()
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
        textField.placeholder = "Введите название привычки"
        textField.backgroundColor = .background
        textField.layer.cornerRadius = 16
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 75),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 87),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func addCategoryButton() {
        view.addSubview(categoryButton)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.setTitle("Категория", for: .normal)
        categoryButton.setTitleColor(.ypBlack, for: .normal)
        categoryButton.titleLabel?.font = .systemFont(ofSize: 17)
        categoryButton.backgroundColor = .background
        categoryButton.addTarget(self, action: #selector (didTapCategoryButton), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            categoryButton.heightAnchor.constraint(equalToConstant: 75),
            categoryButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 186),
            categoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapCategoryButton() {
        
    }
    
    private func addSheduleButton() {
        view.addSubview(sheduleButton)
        sheduleButton.translatesAutoresizingMaskIntoConstraints = false
        sheduleButton.setTitle("Расписание", for: .normal)
        sheduleButton.setTitleColor(.ypBlack, for: .normal)
        sheduleButton.titleLabel?.font = .systemFont(ofSize: 17)
        sheduleButton.backgroundColor = .background
        sheduleButton.addTarget(self, action: #selector (didTapSheduleButton), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            sheduleButton.heightAnchor.constraint(equalToConstant: 75),
            sheduleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 261),
            sheduleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sheduleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapSheduleButton() {
        sheduleViewController.modalPresentationStyle = .pageSheet
        self.present(sheduleViewController, animated: true)
    }
    
    private func addCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.ypRed, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16)
        cancelButton.layer.borderColor = UIColor.ypRed.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 16
        cancelButton.addTarget(self, action: #selector (didTapCancelButton), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -4)
        ])
    }
    
    @objc private func didTapCancelButton () {
        trackersViewController.modalPresentationStyle = .fullScreen
        self.present(trackersViewController, animated: true)
    }
    
    private func addCreateButton() {
        view.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Создать", for: .normal)
        createButton.setTitleColor(.ypWhite, for: .normal)
        createButton.titleLabel?.font = .systemFont(ofSize: 16)
        createButton.backgroundColor = .ypGray
        createButton.layer.cornerRadius = 16
        createButton.addTarget(self, action: #selector (didTapCreateButton), for: UIControl.Event.touchUpInside)
        NSLayoutConstraint.activate([
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 4)
        ])
    }
    
    @objc private func didTapCreateButton () {

    }
}

