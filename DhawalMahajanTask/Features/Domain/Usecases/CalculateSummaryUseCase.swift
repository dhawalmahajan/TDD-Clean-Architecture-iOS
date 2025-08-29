//
//  CalculateSummaryUseCase.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation

public protocol CalculateSummaryUseCase {
    func execute(holdings: [HoldingEntity]) -> PortfolioSummary
}

public final class CalculateSummaryUseCaseImpl: CalculateSummaryUseCase {
    public init() {}
    public func execute(holdings: [HoldingEntity]) -> PortfolioSummary {
        let currentValue = holdings.reduce(0) { $0 + ($1.ltp * Double($1.quantity)) }
        let totalInvestment = holdings.reduce(0) { $0 + ($1.averagePrice * Double($1.quantity)) }
        let todaysPNL = holdings.reduce(0) { $0 + (($1.closePrice - $1.ltp) * Double($1.quantity)) }
        let totalPNL = currentValue - totalInvestment
        return PortfolioSummary(currentValue: currentValue, totalInvestment: totalInvestment, todaysPNL: todaysPNL, totalPNL: totalPNL)
    }
}
