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
    private let portfolioCoordinatorFactory: (UINavigationController, AppContainer) -> PortfolioCoordinator
    init(navigationController: UINavigationController, container: AppContainer,portfolioCoordinatorFactory: @escaping (UINavigationController, AppContainer) -> PortfolioCoordinator = { nav, cont in
        PortfolioCoordinator(navigationController: nav, container: cont)
    }) {
        self.navigationController = navigationController
        self.container = container
        self.portfolioCoordinatorFactory = portfolioCoordinatorFactory
    }

    func start() {
        let coordinator = PortfolioCoordinator(navigationController: navigationController, container: container)
        coordinator.start()
    }
}

