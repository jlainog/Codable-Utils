//
//  KeyedDecodingContainer+Utils.swift
//  Codable-Utils
//
//  Created by Jaime Andres Laino Guerra on 8/5/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public extension KeyedDecodingContainer {
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter codingKey: The key that the decoded value is associated with.
    /// - parameter type: The type of value to decode.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    func decode<T>(_ codingKey: Key,
                   as type: T.Type = T.self) throws -> T where T : Decodable {
        return try decode(type, forKey: codingKey)
    }
    
    /// Decodes a value of the given type for the given key, if present.
    ///
    /// This method returns `nil` if the container does not have a value
    /// associated with `key`, or if the value is null. The difference between
    /// these states can be distinguished with a `contains(_:)` call.
    ///
    /// - parameter codingKey: The key that the decoded value is associated with.
    /// - parameter type: The type of value to decode.
    /// - returns: A decoded value of the requested type, or `nil` if the
    ///   `Decoder` does not have an entry associated with the given key, or if
    ///   the value is a null value.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    func decodeIfPresent<T>(_ codingKey: Key,
                            as type: T.Type = T.self) throws -> T? where T : Decodable {
        return try decodeIfPresent(type, forKey: codingKey)
    }
}
