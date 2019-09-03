//
//  Encodable+AnyTopLevelEncoder.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public extension Encodable {
    
    /// Encodes the current value and returns a JSON representation.
    func encode() throws -> Data {
        let jsonEncoder = JSONEncoder()
        
        if #available(iOS 11.0, OSX 10.13, *) {
            jsonEncoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        } else {
          jsonEncoder.outputFormatting = .prettyPrinted
        }
        
        return try encode(using: jsonEncoder)
    }
    
    /// Encodes the current value and returns a representation according the Encoder Output type.
    ///
    /// - parameter encoder: The encoder to be use.
    /// - returns: A value containing the encoded data.
    /// - throws: `EncodingError.invalidValue` if a non-conforming floating-point value is encountered during encoding, and the encoding strategy is `.throw`.
    /// - throws: An error if any value throws an error during encoding.
    func encode<Encoder: AnyTopLevelEncoder>(using encoder: Encoder) throws -> Encoder.Output {
        return try encoder.encode(self)
    }
}
