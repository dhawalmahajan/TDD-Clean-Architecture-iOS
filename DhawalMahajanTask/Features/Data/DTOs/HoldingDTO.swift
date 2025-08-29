//
//  HoldingDTO.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation
struct Holding: Codable {
    let data: HoldingData
}

// MARK: - DataClass
struct HoldingData: Codable {
    let userHolding: [UserHolding]
}
struct UserHolding: Codable {
    let symbol: String
    let quantity: Int
    let ltp, avgPrice, close: Double
}
