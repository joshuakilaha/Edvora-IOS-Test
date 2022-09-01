//
//  FetchJSONFile.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import Foundation

struct FetchJSONFile {
    /// Decodes JSON File to their respective data types
    /// - Parameters:
    ///   - file: File Name
    ///   - type: Model Type
    /// - Returns: Returns decoded Model type
    static func decodeLocalFile<T: Decodable>(file: String, type: T.Type) throws -> T {
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw JSONFileError.failedToGetContents
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

extension FetchJSONFile {
    enum JSONFileError: Error {
        case failedToGetContents
    }
}
