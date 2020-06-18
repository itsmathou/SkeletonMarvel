//
//  RootCoordinator.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 15/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import UIKit

final class RootCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataController: CharactersDataController = CharactersDataController()
        let viewModel: CharactersViewModel = CharactersViewModel(dataController: dataController)
        let viewController: CharactersViewController = CharactersViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
