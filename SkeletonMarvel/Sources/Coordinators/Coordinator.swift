//
//  Coordinator.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 15/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
