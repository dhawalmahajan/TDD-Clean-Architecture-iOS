//
//  PortfolioSummary.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation

public struct PortfolioSummary: Equatable {
    public let currentValue: Double
    public let totalInvestment: Double
    public let todaysPNL: Double
    public let totalPNL: Double
    public var pnlPercent: Double { totalInvestment == 0 ? 0 : (totalPNL / totalInvestment) * 100 }
}
