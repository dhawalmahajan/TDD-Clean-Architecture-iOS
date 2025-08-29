//
//  MockNetworkService.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import Foundation
import XCTest
@testable import DhawalMahajanTask

// Mock NetworkService
final class MockNetworkService: NetworkService {
    var result: Any?
    var error: Error?

    func request<T: Decodable>(
        _ url: URL,
        method: HTTPMethod,
        body: Data?,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let error = error {
            completion(.failure(error))
        } else if let result = result as? T {
            completion(.success(result))
        } else {
            completion(.failure(NSError(domain: "InvalidMockSetup", code: -1)))
        }
    }
}
