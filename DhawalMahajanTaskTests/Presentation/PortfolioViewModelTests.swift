//
//  PortfolioViewModelTests.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 14/09/25.
//

import XCTest
@testable import DhawalMahajanTask
final class PortfolioViewModelTests: XCTestCase {

    private var getHoldings: MockGetHoldingsUseCase!
        private var calculateSummary: MockCalculateSummaryUseCase!
        private var output: PortfolioViewModelOutputMock!
        private var sut: PortfolioViewModel!  // System Under Test

        override func setUp() {
            super.setUp()
            getHoldings = MockGetHoldingsUseCase()
            calculateSummary = MockCalculateSummaryUseCase()
            output = PortfolioViewModelOutputMock()
            sut = PortfolioViewModel(getHoldings: getHoldings, calculateSummary: calculateSummary)
            sut.output = output
        }

        override func tearDown() {
            sut = nil
            output = nil
            calculateSummary = nil
            getHoldings = nil
            super.tearDown()
        }

    func test_viewDidLoad_emitsLoadingAndLoadedState() {
           // When
           sut.viewDidLoad()

           // Then
           XCTAssertEqual(output.states.count, 2)
           if case .loading = output.states[0] {} else {
               XCTFail("Expected .loading state")
           }
           if case let .loaded(rows, summaryVM, isExpanded) = output.states[1] {
               XCTAssertTrue(rows.isEmpty)
               XCTAssertEqual(summaryVM.currentValue, CurrencyFormatter.string(from: 0))
               XCTAssertFalse(isExpanded)
           } else {
               XCTFail("Expected .loaded state")
           }
       }

       func test_toggleSummary_togglesExpansion() {
           // Given
           sut.viewDidLoad()
           output.reset() // reset capture

           // When
           sut.toggleSummary()

           // Then
           XCTAssertEqual(output.states.count, 1)
           if case let .loaded(_, _, isExpanded) = output.states.first {
               XCTAssertTrue(isExpanded)
           } else {
               XCTFail("Expected .loaded with isExpanded true")
           }
       }

}
