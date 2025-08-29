//
//  MockHoldingsRemoteDataSource.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import XCTest
@testable import DhawalMahajanTask

final class MockHoldingsRemoteDataSource: HoldingsRemoteDataSource {
    var result: Result<[HoldingEntity], Error>?
    
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
