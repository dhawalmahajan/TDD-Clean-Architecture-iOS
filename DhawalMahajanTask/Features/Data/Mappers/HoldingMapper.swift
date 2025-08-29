//
//  HoldingMapper.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation

enum HoldingMapper {
    static func map(_ dto: UserHolding) -> HoldingEntity {
        HoldingEntity(symbol: dto.symbol, ltp: dto.ltp, quantity: dto.quantity, averagePrice: dto.avgPrice, closePrice: dto.close)
    }
}
