//
//  HoldingsRepository.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation

public protocol HoldingsRepository {
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void)
}
