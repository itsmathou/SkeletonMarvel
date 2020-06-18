//
//  SkeletonView.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 18/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import UIKit

final class SkeletonView: UIView {
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    let startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
    let endLocations: [NSNumber] = [1.0, 1.5, 2.0]
    let gradientBackgroundColor: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    let gradientMovingColor: CGColor = UIColor(white: 0.80, alpha: 1.0).cgColor
    let movingAnimationDuration: CFTimeInterval = 0.8
    let delayBetweenAnimationLoops: CFTimeInterval = 1.0
    
    override func layoutSubviews() {
        setupGradient()
        setupAnimation()
    }
    
    func setupGradient() {
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [gradientBackgroundColor, gradientMovingColor, gradientBackgroundColor]
        gradientLayer.locations = startLocations
        layer.addSublayer(gradientLayer)
    }
    
    func setupAnimation() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = movingAnimationDuration
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = movingAnimationDuration + delayBetweenAnimationLoops
        groupAnimation.animations = [animation]
        groupAnimation.repeatCount = .infinity
        gradientLayer.add(groupAnimation, forKey: animation.keyPath)
    }
}
