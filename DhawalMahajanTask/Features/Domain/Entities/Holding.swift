//
//  Holding.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation
public struct HoldingEntity: Equatable {
    public let symbol: String
    public let ltp: Double          // Last traded price
    public let quantity: Int
    public let averagePrice: Double // Avg buy price
    public let closePrice: Double   // Previous close

    public init(symbol: String, ltp: Double, quantity: Int, averagePrice: Double, closePrice: Double) {
        self.symbol = symbol
        self.ltp = ltp
        self.quantity = quantity
        self.averagePrice = averagePrice
        self.closePrice = closePrice
    }
    
    // convenience computed properties for business logic
       var currentValue: Double { ltp * Double(quantity) }
       var totalInvestment: Double { averagePrice * Double(quantity) }
       var pnl: Double { currentValue - totalInvestment }
       var todayPNL: Double { (closePrice - ltp) * Double(quantity) }
}
