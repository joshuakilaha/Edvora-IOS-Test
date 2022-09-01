//
//  NetworkManager.swift
//  Edvora IOS Test
//
//  Created by Mroot on 01/09/2022.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager() //limits to one instance
    
    private init() {}
    
    /// Singleton Func --  Fetchs data from API and decodes from the model file passed
    /// - Parameters:
    ///   - url: API url
    ///   - T: Model : User
    /// - Returns: Decoded Model  i.e   [User]
    func fetchRequest<T: Codable>(_ url: String, T: T.Type) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dataDecoded = try decoder.decode(T.self, from: data)
    
        return dataDecoded
    }
}

extension NetworkManager {
    enum NetworkError: LocalizedError {
        case invalidURL
        case customError(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

// MARK: Network Error Descriprions
extension NetworkManager.NetworkError {
    var errorDescription: String? {
        
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .customError(error: let error):
            return "Something went wrong, \(error.localizedDescription)"
        case .invalidStatusCode:
            return "Status code is out of range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Faild to decode"
        }
    }
}
