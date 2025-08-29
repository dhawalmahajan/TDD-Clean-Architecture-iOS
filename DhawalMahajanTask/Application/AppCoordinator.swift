//
//  AppCoordinator.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation
import UIKit

final class AppCoordinator {
    private let navigationController: UINavigationController
    private let container: AppContainer

    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let coordinator = PortfolioCoordinator(navigationController: navigationController, container: container)
        coordinator.start()
    }
}

