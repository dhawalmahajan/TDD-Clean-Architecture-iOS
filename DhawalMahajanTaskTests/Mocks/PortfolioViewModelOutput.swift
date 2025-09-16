//
//  PortfolioViewModelOutput.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 14/09/25.
//
import Foundation
@testable import DhawalMahajanTask

final class PortfolioViewModelOutputMock: PortfolioViewModelOutput {
    private(set) var states: [PortfolioViewModel.State] = []

    func render(state: PortfolioViewModel.State) {
        states.append(state)
    }
    func reset() {
        states.removeAll()
    }
}
