//
//  MockGetHoldingsUseCase.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import Foundation
import XCTest
@testable import DhawalMahajanTask   



final class MockGetHoldingsUseCase: GetHoldingsUseCase {
    func execute(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        completion(.success([])) // return empty for testing
    }
}
