//
//  Container.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation

struct AppContainer {
    let getHoldings: GetHoldingsUseCase
    let calculateSummary: CalculateSummaryUseCase

    static func build() -> AppContainer? {
        guard let baseURL = URL(string: "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/") else {
                   print("⚠️ Invalid base URL. AppContainer could not be created.")
                   return nil
               }

        let networkService = NetworkServiceImpl(baseURL: baseURL)
        let remote = HoldingsRemoteDataSourceImpl(network: networkService, apiURL: baseURL)
        let repo = HoldingsRepositoryImpl(remote: remote)
        return AppContainer(getHoldings: GetHoldingsUseCaseImpl(repository: repo),
                            calculateSummary: CalculateSummaryUseCaseImpl())
    }
}
