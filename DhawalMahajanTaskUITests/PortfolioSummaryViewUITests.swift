//
//  PortfolioSummaryViewUITests.swift
//  DhawalMahajanTaskUITests
//
//  Created by Dhawal Mahajan on 12/09/25.
//

import XCTest

final class PortfolioSummaryViewUITests: XCTestCase {

    var app: XCUIApplication!

       override func setUp() {
           super.setUp()
           continueAfterFailure = false
           app = XCUIApplication()
           app.launch()
       }

       func testSummaryToggle() {
           let summaryToggleButton = app.otherElements["summaryToggleButton"]
           XCTAssertTrue(summaryToggleButton.exists, "Toggle button should exist")

           // Initial state: rows hidden
           XCTAssertFalse(app.otherElements["currentValueRow"].exists)

           // Tap to expand
           summaryToggleButton.tap()

           // Now rows should exist
           XCTAssertTrue(app.otherElements["currentValueRow"].waitForExistence(timeout: 2))
           XCTAssertTrue(app.otherElements["totalInvestmentRow"].exists)
           XCTAssertTrue(app.otherElements["todaysPNLRow"].exists)

           // Tap again to collapse
           summaryToggleButton.tap()
           XCTAssertFalse(app.otherElements["currentValueRow"].exists)
       }

       func testPNLValueDisplays() {
           let pnlValueLabel = app.staticTexts["pnlValueLabel"]
           XCTAssertTrue(pnlValueLabel.exists, "PNL value label should exist")
           // Optional: verify text matches expected formatting
           XCTAssertTrue(pnlValueLabel.label.contains("%") || pnlValueLabel.label.contains("₹"))
       }
}
