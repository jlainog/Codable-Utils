//
//  Encodable+Utils.swift
//  Codable-Utils
//
//  Created by jaime Laino Guerra on 7/22/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import Foundation

extension CustomDebugStringConvertible where Self: Encodable  {
    public var debugDescription: String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        jsonEncoder.keyEncodingStrategy = .useDefaultKeys
        return try! encode(using: JSONStringEncoder(encoder: jsonEncoder))
    }
}
