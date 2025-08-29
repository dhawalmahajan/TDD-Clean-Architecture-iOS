//
//  SpyPortfolioCoordinator.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import Foundation
@testable import DhawalMahajanTask
final class SpyPortfolioCoordinator: PortfolioCoordinator {
    private(set) var startCalled = false

    override func start() {
        startCalled = true
    }
}
