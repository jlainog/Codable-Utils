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
    
    /// Decodes a Dictionary where the key conform to `CodingKey`
    ///
    /// This method returns a Dictionary from a nested container
    /// from a given `codingKey` where each key of the dictionary
    /// is also a `codingKey`.
    ///
    ///     struct Photo: Codable {
    ///         enum URLKind: String, CodingKey {
    ///             case raw, full, regular, small, thumb
    ///         }
    ///
    ///         enum CodingKeys: String, CodingKey {
    ///             case urls
    ///         }
    ///
    ///         let urls: [URLKind: URL]
    ///
    ///         public init(from decoder: Decoder) throws {
    ///             let container = try decoder.container(keyedBy: CodingKeys.self)
    ///             urls = try container.decodeDictionary(.urls)
    ///         }
    ///     }
    ///
    /// - Parameter codingKey: the key that the decoded value is associated with
    func decodeDictionary<K, V>(_ codingKey: Key) throws -> Dictionary<K, V> where K: CodingKey, V: Decodable {
            let container = try nestedContainer(keyedBy: K.self,
                                                forKey: codingKey)
            return try container
                .allKeys
                .reduce(into: Dictionary<K, V>()) { result, key in
                    result[key] = try container.decode(key)
            }
    }
}
