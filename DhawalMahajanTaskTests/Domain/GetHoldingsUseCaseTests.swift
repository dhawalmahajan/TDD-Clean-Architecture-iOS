//
//  FetchPortfolioUseCaseTests.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import XCTest
@testable import DhawalMahajanTask
final class GetHoldingsUseCaseTests: XCTestCase {
    private var repository: MockHoldingsRepository!
       private var sut: GetHoldingsUseCaseImpl!
       override func setUp() {
           super.setUp()
           repository = MockHoldingsRepository()
           sut = GetHoldingsUseCaseImpl(repository: repository)
       }
       
       override func tearDown() {
           repository = nil
           sut = nil
           super.tearDown()
       }
       
       func testExecute_returnsHoldingsOnSuccess() {
           let expected = [
            HoldingEntity(symbol: "UCOBANK", ltp: 120, quantity: 10, averagePrice: 100, closePrice: 110)
           ]
           repository.result = .success(expected)
           
           let expectation = self.expectation(description: "Completion called")
           
           sut.execute { result in
               switch result {
               case .success(let holdings):
                   XCTAssertEqual(holdings.count, 1)
                   XCTAssertEqual(holdings.first?.symbol, "UCOBANK")
               case .failure:
                   XCTFail("Expected success but got failure")
               }
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 1.0)
       }
       
       func testExecute_returnsErrorOnFailure() {
           enum TestError: Error { case somethingWentWrong }
           repository.result = .failure(TestError.somethingWentWrong)
           
           let expectation = self.expectation(description: "Completion called")
           
           sut.execute { result in
               switch result {
               case .success:
                   XCTFail("Expected failure but got success")
               case .failure(let error):
                   XCTAssertTrue(error is TestError)
               }
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 1.0)
       }
}
