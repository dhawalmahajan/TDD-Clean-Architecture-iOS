//
//  NetworkService.swift
//  DhawalMahajanTask
//
//  Created by Dhawal Mahajan on 28/08/25.
//

import Foundation
public protocol NetworkService {
    func request<T: Decodable>(_ url: URL,
                                  method: HTTPMethod,
                                  body: Data?,
                                  completion: @escaping (Result<T, Error>) -> Void)
}


public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case patch   = "PATCH"
}
