//
//  HoldingsRemoteDataSourceTests.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import XCTest
@testable import DhawalMahajanTask
final class HoldingsRemoteDataSourceTests: XCTestCase {
    private var mockNetwork: MockNetworkService!
      private var sut: HoldingsRemoteDataSourceImpl!
      private var testURL: URL!
      override func setUp() {
          super.setUp()
          mockNetwork = MockNetworkService()
          testURL = URL(string: "https://example.com/holdings")!
          sut = HoldingsRemoteDataSourceImpl(network: mockNetwork, apiURL: testURL)
      }

      override func tearDown() {
          mockNetwork = nil
          sut = nil
          super.tearDown()
      }

      func testFetchHoldings_success_returnsEntities() {
          let dto = UserHolding(symbol: "UCOBANK", quantity: 10, ltp: 120, avgPrice: 100, close: 110)
          let holding = Holding(data: .init(userHolding: [dto]))
          mockNetwork.result = holding

          let expectation = self.expectation(description: "Completion called")

          sut.fetchHoldings { result in
              switch result {
              case .success(let entities):
                  XCTAssertEqual(entities.count, 1)
                  XCTAssertEqual(entities.first?.symbol, "UCOBANK")
                  XCTAssertEqual(entities.first?.quantity, 10)
              case .failure:
                  XCTFail("Expected success but got failure")
              }
              expectation.fulfill()
          }

          wait(for: [expectation], timeout: 1.0)
      }

      func testFetchHoldings_failure_returnsError() {
          enum TestError: Error { case network }
          mockNetwork.error = TestError.network

          let expectation = self.expectation(description: "Completion called")

          sut.fetchHoldings { result in
              switch result {
              case .success:
                  XCTFail("Expected failure but got success")
              case .failure(let error):
                  XCTAssertTrue(error is TestError, "Expected TestError but got \(error)")
              }
              expectation.fulfill()
          }

          wait(for: [expectation], timeout: 1.0)
      }

}
