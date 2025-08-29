//
//  CalculatePortfolioUseCaseTests.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import XCTest
@testable import DhawalMahajanTask
final class CalculateSummaryUseCaseTests: XCTestCase {
    private var sut: CalculateSummaryUseCaseImpl!

    override func setUp() {
        super.setUp()
        sut = CalculateSummaryUseCaseImpl()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testExecute_withSingleHolding_calculatesCorrectSummary() {
        let holding = HoldingEntity(
            symbol: "UCOBANK",
            ltp: 120, quantity: 10,
            averagePrice: 100,
            closePrice: 110
        )

        let summary = sut.execute(holdings: [holding])

        XCTAssertEqual(summary.currentValue, 1200, "CurrentValue should be ltp * qty")
        XCTAssertEqual(summary.totalInvestment, 1000, "Investment should be avgPrice * qty")
        XCTAssertEqual(summary.todaysPNL, -100, "Today's PNL should be (close - ltp) * qty = (110-120)*10")
        XCTAssertEqual(summary.totalPNL, 200, "Total PNL should be currentValue - investment")
    }

    func testExecute_withMultipleHoldings_calculatesAggregateCorrectly() {
        let holdings = [
            HoldingEntity(symbol: "ASHOKLEY", ltp: 119.1, quantity: 2, averagePrice: 100, closePrice: 120),
            HoldingEntity(symbol: "UCOBANK", ltp: 50, quantity: 3, averagePrice: 40, closePrice: 55)
        ]

        let summary = sut.execute(holdings: holdings)

        let expectedCurrent = (119.1 * 2) + (50 * 3)  // 238.2 + 150 = 388.2
        let expectedInvestment = (100 * 2) + Double(40 * 3) // 200 + 120 = 320
        let expectedTodaysPNL = ((120 - 119.1) * 2) + ((55 - 50) * 3) // 1.8 + 15 = 16.8
        let expectedTotalPNL = expectedCurrent - expectedInvestment // 68.2

        XCTAssertEqual(summary.currentValue, expectedCurrent, accuracy: 0.001)
        XCTAssertEqual(summary.totalInvestment, expectedInvestment, accuracy: 0.001)
        XCTAssertEqual(summary.todaysPNL, expectedTodaysPNL, accuracy: 0.001)
        XCTAssertEqual(summary.totalPNL, expectedTotalPNL, accuracy: 0.001)
    }

    func testExecute_withEmptyHoldings_returnsZeros() {
        let summary = sut.execute(holdings: [])
        XCTAssertEqual(summary.currentValue, 0)
        XCTAssertEqual(summary.totalInvestment, 0)
        XCTAssertEqual(summary.todaysPNL, 0)
        XCTAssertEqual(summary.totalPNL, 0)
    }
   

}
