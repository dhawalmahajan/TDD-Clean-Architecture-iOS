//
//  MockHoldingsRepository.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import Foundation
@testable import DhawalMahajanTask
import XCTest

final class MockHoldingsRepository: HoldingsRepository {
    var result: Result<[HoldingEntity], Error>?
    
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
