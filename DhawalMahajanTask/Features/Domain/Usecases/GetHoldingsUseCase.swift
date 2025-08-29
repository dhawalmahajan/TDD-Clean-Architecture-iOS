//
//  GetHoldingsUseCase.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation

public protocol GetHoldingsUseCase {
    func execute(completion: @escaping (Result<[HoldingEntity], Error>) -> Void)
}

public final class GetHoldingsUseCaseImpl: GetHoldingsUseCase {
    private let repository: HoldingsRepository
    public init(repository: HoldingsRepository) { self.repository = repository }
    public func execute(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        repository.fetchHoldings(completion: completion)
    }
}

