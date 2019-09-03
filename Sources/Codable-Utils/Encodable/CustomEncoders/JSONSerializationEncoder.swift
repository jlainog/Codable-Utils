//
//  JSONSerializationEncoder.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public struct JSONSerializationEncoder: AnyTopLevelEncoder {
    public typealias Output = [AnyHashable: Any]
    
    public let encoder: JSONEncoder = JSONEncoder()

    public init() {}
    
    /// Encodes the given top-level value and returns a Foundation object from JSON data.
    ///
    /// - parameter value: The value to encode.
    /// - returns: A foundation object repesenting the JSON.
    /// - throws: `EncodingError.invalidValue` if the encoded data can't be repesented in a foundation object.
    /// - throws: An error if any value throws an error during encoding.
    public func encode<T>(_ value: T) throws -> [AnyHashable : Any] where T : Encodable {
        let data = try encoder.encode(value)
        let serialization = try JSONSerialization.jsonObject(with: data,
                                                             options: .allowFragments)
        guard let output = serialization as? [AnyHashable: Any] else {
            throw EncodingError.invalidValue(value, .init(codingPath: [],
                                                          debugDescription: "Can't Turn into Dictionary"))
        }
        return output
    }
}
