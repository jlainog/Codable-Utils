//
//  JSONStringEncoder.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public struct JSONStringEncoder: AnyTopLevelEncoder {
    public typealias Output = String
    
    public let encoder: JSONEncoder
    
    public init(encoder: JSONEncoder = .init()) {
        self.encoder = encoder
    }
    
    /// Encodes the given top-level value and returns its String JSON representation.
    ///
    /// - parameter value: The value to encode.
    /// - returns: A String containing the encoded JSON data.
    /// - throws: `EncodingError.invalidValue` if a non-conforming floating-point value is encountered during encoding, and the encoding strategy is `.throw`.
    /// - throws: An error if any value throws an error during encoding.
    public func encode<T>(_ value: T) throws -> String where T : Encodable {
        let data = try encoder.encode(value)
        return String(decoding: data, as: UTF8.self)
    }
}
