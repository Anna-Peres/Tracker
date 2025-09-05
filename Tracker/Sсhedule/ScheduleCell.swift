//
//  ScheduleCell.swift
//  Tracker
//
//  Created by Анна Перескокова on 02.09.2025.
//

import UIKit

final class ScheduleCell: UITableViewCell {
    //MARK: UI elements  
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .ypBlack
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var groupSwitch: UISwitch = {
        let groupSwitch = UISwitch()
        groupSwitch.translatesAutoresizingMaskIntoConstraints = false
        groupSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        groupSwitch.isEnabled = true
        groupSwitch.isUserInteractionEnabled = true
        groupSwitch.onTintColor = .ypBlue
        return groupSwitch
    }()
    
    //MARK: Services
    var onSwitchChanged: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, isOn: Bool) {
        titleLabel.text = title
        groupSwitch.isOn = isOn
    }
    
    private func addViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(groupSwitch)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            groupSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            groupSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        onSwitchChanged?(sender.isOn)
    }
}
