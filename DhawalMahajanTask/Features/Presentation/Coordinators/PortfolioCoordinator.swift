//
//  PortfolioCoordinator.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//


import UIKit

final class PortfolioCoordinator {
    private let navigationController: UINavigationController
    private let container: AppContainer

    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let vm = PortfolioViewModel(getHoldings: container.getHoldings, calculateSummary: container.calculateSummary)
        let vc = PortfolioViewController(viewModel: vm)
        vc.title = "Portfolio"
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(vc, animated: true)
    }
}
