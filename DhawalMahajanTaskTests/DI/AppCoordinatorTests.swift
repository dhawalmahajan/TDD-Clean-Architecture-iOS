//
//  AppContainerTests.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import XCTest
@testable import DhawalMahajanTask
final class AppCoordinatorTests: XCTestCase {
    func testStart_createsAndStartsPortfolioCoordinator() {
           let navController = UINavigationController()
           let container = AppContainer(
               getHoldings: MockGetHoldingsUseCase(),
               calculateSummary: MockCalculateSummaryUseCase()
           )

           var spyCoordinator: SpyPortfolioCoordinator?

           let sut = AppCoordinator(
               navigationController: navController,
               container: container,
               portfolioCoordinatorFactory: { nav, cont in
                   let spy = SpyPortfolioCoordinator(navigationController: nav, container: cont)
                   spyCoordinator = spy
                   return spy
               }
           )

           sut.start()

           XCTAssertNotNil(spyCoordinator, "AppCoordinator should create a PortfolioCoordinator")
           XCTAssertTrue(spyCoordinator?.startCalled == true, "AppCoordinator should call start() on PortfolioCoordinator")
       }
}
