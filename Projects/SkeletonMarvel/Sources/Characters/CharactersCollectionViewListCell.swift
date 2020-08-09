//
//  CharactersCollectionViewListCell.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 17/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import UIKit

final class CharactersCollectionViewListCell: UICollectionViewListCell {
    
    let nameLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawSeparator(with: rect)
    }
    
    func update(with name: String) {
        nameLabel.text = name
    }
}

private extension CharactersCollectionViewListCell {
    func setupViews() {
        contentView.addSubview(nameLabel)
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
    
    func drawSeparator(with rect: CGRect) {
        let path = UIBezierPath()
        let color: UIColor = UIColor(white: 0.75, alpha: 1.0)
        color.setStroke()
        path.lineWidth = 1.0
        let yPos = rect.maxY - 0.5
        let indentation: CGFloat = 10
        path.move(to: CGPoint(x: rect.minX + indentation, y: yPos))
        path.addLine(to: CGPoint(x: rect.maxX - indentation, y: yPos))
        path.stroke()
    }
}
