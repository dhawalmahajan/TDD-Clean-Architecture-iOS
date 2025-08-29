//
//  MockCalculateSummaryUseCase.swift
//  DhawalMahajanTaskTests
//
//  Created by Dhawal Mahajan on 29/08/25.
//

import Foundation
@testable import DhawalMahajanTask
final class MockCalculateSummaryUseCase: CalculateSummaryUseCase {
    func execute(holdings: [HoldingEntity]) -> PortfolioSummary {
        return PortfolioSummary(
            currentValue: 0,
            totalInvestment: 0,
            todaysPNL: 0,
            totalPNL: 0
        )
    }
}
