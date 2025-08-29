//
//  NetworkServiceImpl.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation
final class NetworkServiceImpl: NetworkService {
  
    
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    func request<T>(_ url: URL, method: HTTPMethod, body: Data?, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        var request = URLRequest(url: url)
               request.httpMethod = method.rawValue
               request.httpBody = body
               
               if body != nil {
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               }
               
               session.dataTask(with: request) { data, response, error in
                   if let error = error {
                       completion(.failure(error))
                       return
                   }
                   
                   guard let data = data else {
                       completion(.failure(NSError(domain: "NetworkService",
                                                   code: -1,
                                                   userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                       return
                   }
                   
                   do {
                       let decoded = try JSONDecoder().decode(T.self, from: data)
                       completion(.success(decoded))
                   } catch {
                       completion(.failure(error))
                   }
               }.resume()
    }
}
