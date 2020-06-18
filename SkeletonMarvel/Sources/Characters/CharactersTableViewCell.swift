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
    // TODO: Refactor this to only draw a line
    let separatorView: UIView = UIView()
    let skeletonView: SkeletonView = SkeletonView()
    
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
        contentView.addSubview(separatorView)
        contentView.addSubview(skeletonView)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.numberOfLines = 0
        
        separatorView.backgroundColor = UIColor(white: 0.75, alpha: 1.0)
        
        initializeConstraints()
    }
    
    func initializeConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            skeletonView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            skeletonView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
