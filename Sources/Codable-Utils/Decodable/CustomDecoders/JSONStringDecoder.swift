//
//  JSONStringDecoder.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public struct JSONStringDecoder: AnyTopLevelDecoder {
    public typealias Input = String
    public let decoder: JSONDecoder

    public init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
    
    /// Decodes a top-level value of the given type from the given JSON String representation.
    ///
    /// - parameter type: The type of the value to decode.
    /// - parameter input: The string to decode from.
    /// - returns: A value of the requested type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid String JSON.
    /// - throws: An error if any value throws an error during decoding.
    public func decode<T>(_ type: T.Type, from input: String) throws -> T where T : Decodable {
        let data = input.data(using: .utf8)!
        return try decoder.decode(type, from: data)
    }
}
