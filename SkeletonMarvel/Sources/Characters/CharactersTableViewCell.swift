//
//  CharactersTableViewCell.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 17/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import UIKit

final class CharactersTableViewCell: UITableViewCell {

    let nameLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with name: String) {
        nameLabel.text = name
    }
}

private extension CharactersTableViewCell {
    func setupViews() {
        contentView.addSubview(nameLabel)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.numberOfLines = 0
        
        initializeConstraints()
    }
    
    func initializeConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
