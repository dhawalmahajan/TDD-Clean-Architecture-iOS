//
//  HoldingsRepositoryImpl.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation
final class HoldingsRepositoryImpl: HoldingsRepository {
    private let remote: HoldingsRemoteDataSource

    init(remote: HoldingsRemoteDataSource) {
        self.remote = remote
    }

    // Dependency Inversion: Domain depends on protocol; Data implements it
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        remote.fetchHoldings(completion: completion)
    }
}
