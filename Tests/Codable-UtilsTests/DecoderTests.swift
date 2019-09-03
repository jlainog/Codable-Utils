//
//  DecoderTests.swift
//  Codable-UtilsTests
//
//  Created by Jaime Andres Laino Guerra on 8/11/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import XCTest
import Codable_Utils

class DecoderTests: XCTestCase {
    
    static var allTests = [
        ("testJSONStringDecoder", testJSONStringDecoder),
        ("testJSONSerializationDecoder", testJSONSerializationDecoder),
        ("testDecodeExtension", testDecodeExtension),
    ]

    struct Article: Codable {
        var name: String
    }
    let jsonString = "{\"name\":\"jaime\"}"

    func testJSONStringDecoder() throws {
        let decoder = JSONStringDecoder()
        let article = try decoder.decode(Article.self, from: jsonString)
        
        XCTAssertEqual(article.name, "jaime")
    }
    
    func testJSONSerializationDecoder() throws {
        let decoder = JSONSerializationDecoder()
        let article = try decoder.decode(Article.self, from: ["name": "jaime"])
        
        XCTAssertEqual(article.name, "jaime")
    }
    
    func testDecodeExtension() throws {
        let data = jsonString.data(using: .utf8)!
        let article = try Article.decode(from: data)
        let otherArticle = try Article.decode(from: jsonString,
                                              using: JSONStringDecoder())
        
        XCTAssertEqual(article.name, "jaime")
        XCTAssertEqual(otherArticle.name, "jaime")
    }
}
