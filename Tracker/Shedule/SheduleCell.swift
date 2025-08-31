//
//  SheduleCell.swift
//  Tracker
//
//  Created by Анна Перескокова on 31.08.2025.
//

import UIKit

final class ScheduleCell: UITableViewCell {
      
    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = UIColor(resource: .ypBlue)
        switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    //MARK: Services
    var onSwitchChanged: ((Bool) -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(isOn: Bool) {
        switchControl.isOn = isOn
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        onSwitchChanged?(sender.isOn)
    }
}

