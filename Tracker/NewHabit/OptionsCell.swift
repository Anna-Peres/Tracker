//
//  OptionsCell.swift
//  Tracker
//
//  Created by Анна Перескокова on 18.09.2025.
//

import UIKit

final class OptionsCell: UICollectionViewCell {
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32)
        return label
    }()
    
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeFramed(cellColor: UIColor) {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 3
        let frameColor = cellColor.withAlphaComponent(0.3)
        contentView.layer.borderColor = frameColor.cgColor
    }
    
    func deleteFrame() {
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = nil
    }
       
    private func setupUI() {
        contentView.addSubview(emojiLabel)
        contentView.addSubview(colorView)
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
