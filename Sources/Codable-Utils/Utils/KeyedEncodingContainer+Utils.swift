//
//  KeyedEncodingContainer+Utils.swift
//  Codable-Utils
//
//  Created by Jaime Andres Laino Guerra on 8/5/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public extension KeyedEncodingContainer {
    /// Encodes a Dictionary where the key conform to `CodingKey`
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
    ///         public func encode(to encoder: Encoder) throws {
    ///             var container = encoder.container(keyedBy: CodingKeys.self)
    ///             try container.encodeDictionary(urls, forKey: .urls)
    ///         }
    ///     }
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid
    mutating func encodeDictionary<K, V>(_ value: Dictionary<K, V>,
                                         forKey codingKey: Key) throws where K: CodingKey, V: Encodable {
        let dictionary = value.reduce(into: [String: V]()) { (result, dict) in
            result[dict.key.stringValue] = dict.value
        }
        try encode(dictionary, forKey: codingKey)
    }
}
