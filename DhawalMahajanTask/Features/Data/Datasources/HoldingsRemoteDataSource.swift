//
//  HoldingsRemoteDataSource.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation
protocol HoldingsRemoteDataSource {
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void)
}

final class HoldingsRemoteDataSourceImpl: HoldingsRemoteDataSource {
    private let network: NetworkService
    private let apiURL: URL
    init(network: NetworkService, apiURL: URL) {
          self.network = network
          self.apiURL = apiURL
      }
    
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        
//        network.request(endpoint, completion: completion)
              
        network.request(apiURL, method: .get, body: nil) { (result: Result<Holding, Error>) in
                  switch result {
                  case .success(let response):
                      let entities = response.data.userHolding.map(HoldingMapper.map)
                      completion(.success(entities))
                  case .failure(let error):
                      completion(.failure(error))
                  }
              }
    }
}
final class HoldingsRemoteDataSourceStub: HoldingsRemoteDataSource {
    func fetchHoldings(completion: @escaping (Result<[HoldingEntity], Error>) -> Void) {
        completion(.failure(NSError(domain: "Remote not implemented", code: -1)))
    }
}
