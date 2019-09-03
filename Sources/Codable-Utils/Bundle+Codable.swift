//
//  Bundle+Codable.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/31/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

public extension Bundle {
    struct RuntimeError: Error {
        let message: String
        
        init(_ message: String) {
            self.message = message
        }
    }
    
    /// load the content of the resource `filename` as Data
    /// - Parameter filename: a name for the resource to be loaded
    func load(_ filename: String) throws -> Data {
        guard let file = url(forResource: filename, withExtension: nil) else {
            throw RuntimeError("Couldn't find \(filename) in bundle.")
        }
        
        return try Data(contentsOf: file)
    }
    
    /// load the content of a resource and decode into a given type it using a Top Level Decoder
    /// - Parameter filename: the resource to be load
    /// - Parameter decoder: the Top Level Decoder to be use
    /// - Parameter type: the type to decode to
    func load<T: Decodable, Decoder: AnyTopLevelDecoder>
        (_ filename: String,
         using decoder: Decoder,
         as type: T.Type = T.self)
        throws -> T where Decoder.Input == Data {
            let data = try load(filename)
            return try decoder.decode(type, from: data)
    }
}
