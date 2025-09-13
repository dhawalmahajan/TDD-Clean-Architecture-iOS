//
//  PortfolioViewControllerUITests.swift
//  DhawalMahajanTaskUITests
//
//  Created by Dhawal Mahajan on 12/09/25.
//

import XCTest

final class PortfolioViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

       override func setUp() {
           super.setUp()
           continueAfterFailure = false
           app = XCUIApplication()
           app.launch()
       }

       func testSummaryCardToggle() {
           let summaryCard = app.otherElements["portfolioSummaryCard"]
           XCTAssertTrue(summaryCard.exists, "Summary card should exist")

           // Tap toggle button inside summary card
           let toggleButton = app.buttons["summaryToggleButton"]
           XCTAssertTrue(toggleButton.exists, "Toggle button should exist")

           toggleButton.tap()
           // Add expectation/assertion for height change, or check state via UI
       }

       func testTableViewLoads() {
           let tableView = app.tables["portfolioTableView"]
           XCTAssertTrue(tableView.exists, "Portfolio table should exist")

           // Example: wait for cells
           let firstCell = tableView.cells.element(boundBy: 0)
           XCTAssertTrue(firstCell.waitForExistence(timeout: 3), "First holding cell should load")
       }
}
