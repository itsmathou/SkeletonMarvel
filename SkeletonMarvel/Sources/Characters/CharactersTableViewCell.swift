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
    let skeletonView: SkeletonView = SkeletonView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        startAnimation()
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
    
    func startAnimation() {
        setupAnimationView()
    }
    
    func stopAnimation() {
        disableAnimation()
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
    
    func setupAnimationView() {
        contentView.addSubview(skeletonView)
        
        skeletonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skeletonView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            skeletonView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func disableAnimation() {
        skeletonView.removeFromSuperview()
    }
}
