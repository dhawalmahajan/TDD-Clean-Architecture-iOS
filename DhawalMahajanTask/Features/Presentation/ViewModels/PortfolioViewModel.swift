//
//  PortfolioViewModel.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import UIKit
protocol PortfolioViewModelInput {
    func viewDidLoad()
    func toggleSummary()
}

protocol PortfolioViewModelOutput: AnyObject {
    func render(state: PortfolioViewModel.State)
}

final class PortfolioViewModel: PortfolioViewModelInput {
    enum State {
        case loading
        case loaded(rows: [HoldingRowViewModel], summary: SummaryViewModel, isExpanded: Bool)
        case error(String)
    }

    private let getHoldings: GetHoldingsUseCase
    private let calculateSummary: CalculateSummaryUseCase

    private(set) var isExpanded: Bool = false
    weak var output: PortfolioViewModelOutput?

    private var holdings: [HoldingEntity] = []

    init(getHoldings: GetHoldingsUseCase, calculateSummary: CalculateSummaryUseCase) {
        self.getHoldings = getHoldings
        self.calculateSummary = calculateSummary
    }

    func viewDidLoad() {
        output?.render(state: .loading)
        getHoldings.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let holdings):
                self.holdings = holdings
                self.emitLoaded()
            case .failure(let error):
                self.output?.render(state: .error(error.localizedDescription))
            }
        }
    }

    func toggleSummary() {
        isExpanded.toggle()
        emitLoaded()
    }

    private func emitLoaded() {
        let rows = holdings.map { HoldingRowViewModel(model: $0) }
        let summaryEntity = calculateSummary.execute(holdings: holdings)
        let summaryVM = SummaryViewModel(entity: summaryEntity)
        output?.render(state: .loaded(rows: rows, summary: summaryVM, isExpanded: isExpanded))
    }
}

// MARK: - Row ViewModels
struct HoldingRowViewModel: Equatable {
    let name: String
    let ltpText: String
    let qtyText: String
    let pnlText: String
    let pnlColor: UIColor

    init(model: HoldingEntity) {
        self.name = model.symbol
        self.ltpText = CurrencyFormatter.string(from: model.ltp)
        self.qtyText = "NET QTY: \(model.quantity)"
        let pnl = (model.ltp - model.averagePrice) * Double(model.quantity)
        self.pnlText = CurrencyFormatter.string(from: pnl)
        self.pnlColor = pnl >= 0 ? .pnlGreen : .pnlRed
    }
}

struct SummaryViewModel: Equatable {
    let currentValue: String
    let totalInvestment: String
    let todaysPNL: String
    let totalPNL: String
    let totalPNLColor: UIColor
    let pnlPercentText: String

    init(entity: PortfolioSummary) {
        currentValue = CurrencyFormatter.string(from: entity.currentValue)
        totalInvestment = CurrencyFormatter.string(from: entity.totalInvestment)
        todaysPNL = CurrencyFormatter.string(from: entity.todaysPNL)
        totalPNL = CurrencyFormatter.string(from: entity.totalPNL)
        totalPNLColor = entity.totalPNL >= 0 ? .pnlGreen : .pnlRed
        let percent = String(format: "%.2f%%", entity.pnlPercent)
        pnlPercentText = "(\(percent))"
    }
}
