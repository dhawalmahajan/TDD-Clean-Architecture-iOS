//
//  HoldingsRemoteDataSourceStub.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import Foundation
@testable import DhawalMahajanTask
final class HoldingsRemoteDataSourceStub: HoldingsRemoteDataSource {
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        completion(.failure(NSError(domain: "Remote not implemented", code: -1)))
    }
}
