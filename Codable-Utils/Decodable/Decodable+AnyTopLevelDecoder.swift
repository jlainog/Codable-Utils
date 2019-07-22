//
//  Decodable+AnyTopLevelDecoder.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public extension Decodable {
    
    /// Decodes a value of the current type from the given Input using a JSONDecoder.
    ///
    /// - parameter input: The repesentation to decode from.
    /// - returns: A value of the current type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid.
    /// - throws: An error if any value throws an error during decoding.
    static func decode(from input: Data) throws -> Self {
        return try decode(from: input, using: JSONDecoder())
    }
    
    /// Decodes a value of the current type from the given Input using any top level decoder.
    ///
    /// - parameter input: The repesentation to decode from.
    /// - parameter decoder: The decoder to be use.
    /// - returns: A value of the current type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid.
    /// - throws: An error if any value throws an error during decoding.
    static func decode<Decoder: AnyTopLevelDecoder>(from input: Decoder.Input,
                                                    using decoder: Decoder) throws -> Self {
       return try decoder.decode(Self.self, from: input)
    }
}
