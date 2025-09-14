//
//  HoldingCellUITests.swift
//  DhawalMahajanTaskUITests
//
//  Created by Dhawal Mahajan on 13/09/25.
//

import XCTest

final class HoldingCellUITests: XCTestCase {
        var app: XCUIApplication!

        override func setUp() {
            super.setUp()
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
        }

        func testHoldingCellDisplaysData() {
            let table = app.tables["portfolioTableView"]  // your table identifier
            XCTAssertTrue(table.exists)

            let firstCell = table.cells.element(boundBy: 0)
            XCTAssertTrue(firstCell.exists)

            let nameLabel = firstCell.staticTexts["holdingNameLabel"]
            XCTAssertTrue(nameLabel.exists)
            XCTAssertFalse(nameLabel.label.isEmpty)

            let ltpLabel = firstCell.staticTexts["holdingLTPLabel"]
            XCTAssertTrue(ltpLabel.exists)

            let qtyLabel = firstCell.staticTexts["holdingQtyLabel"]
            XCTAssertTrue(qtyLabel.exists)

            let pnlLabel = firstCell.staticTexts["holdingPNLLabel"]
            XCTAssertTrue(pnlLabel.exists)
        }
    
}
