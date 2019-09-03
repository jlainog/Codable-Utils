//
//  AnyTopLevelEncoder.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

/// Protocol to define a general interface for TopLevelEncoders
///
/// Conforming Types: JSONEncoder, PropertyListEncoder
public protocol AnyTopLevelEncoder {
    associatedtype Output

    /// Encodes the given top-level value and returns a representation according the conforming type.
    ///
    /// - parameter value: The value to encode.
    /// - returns: A new `Data` value containing the encoded JSON data.
    /// - throws: `EncodingError.invalidValue` if a non-conforming floating-point value is encountered during encoding, and the encoding strategy is `.throw`.
    /// - throws: An error if any value throws an error during encoding.
    func encode<T>(_ value: T) throws -> Self.Output where T : Encodable
}

extension JSONEncoder: AnyTopLevelEncoder {}
extension PropertyListEncoder: AnyTopLevelEncoder {}
