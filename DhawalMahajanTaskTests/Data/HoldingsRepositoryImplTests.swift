//
//  HoldingsRepositoryImplTests.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import XCTest
@testable import DhawalMahajanTask

final class HoldingsRepositoryImplTests: XCTestCase {
    private var mockRemote: MockHoldingsRemoteDataSource!
        private var sut: HoldingsRepositoryImpl!
        
        override func setUp() {
            super.setUp()
            mockRemote = MockHoldingsRemoteDataSource()
            sut = HoldingsRepositoryImpl(remote: mockRemote)
        }
        
        override func tearDown() {
            mockRemote = nil
            sut = nil
            super.tearDown()
        }
        
        func testFetchHoldings_success_returnsEntities() {
            let expected = [
                HoldingEntity(symbol: "UCOBANK", ltp: 120, quantity: 10, averagePrice: 100, closePrice: 110)
            ]
            mockRemote.result = .success(expected)
            
            let expectation = self.expectation(description: "Completion called")
            
            sut.fetchHoldings { result in
                switch result {
                case .success(let entities):
                    XCTAssertEqual(entities.count, 1)
                    XCTAssertEqual(entities.first?.symbol, "UCOBANK")
                case .failure:
                    XCTFail("Expected success but got failure")
                }
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
        
        func testFetchHoldings_failure_returnsError() {
            enum TestError: Error { case someFailure }
            mockRemote.result = .failure(TestError.someFailure)
            
            let expectation = self.expectation(description: "Completion called")
            
            sut.fetchHoldings { result in
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
