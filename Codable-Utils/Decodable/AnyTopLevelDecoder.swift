//
//  AnyTopLevelDecoder.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

/// Protocol to define a general interface for TopLevelDecoders
///
/// Conforming Types: JSONDecoder
public protocol AnyTopLevelDecoder {
    associatedtype Input
    
    /// Decodes a top-level value of the given type from the given Input.
    ///
    /// - parameter type: The type of the value to decode.
    /// - parameter input: The repesentation to decode from.
    /// - returns: A value of the requested type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid.
    /// - throws: An error if any value throws an error during decoding.
    func decode<T>(_ type: T.Type, from input: Self.Input) throws -> T where T : Decodable
}

extension JSONDecoder: AnyTopLevelDecoder {}
