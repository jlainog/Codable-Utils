//
//  EncoderTests.swift
//  Codable-UtilsTests
//
//  Created by Jaime Andres Laino Guerra on 8/11/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import XCTest
import Codable_Utils

class EncoderTests: XCTestCase {
    struct Article: Codable, CustomDebugStringConvertible {
        var name: String
    }
    let article = Article(name: "jaime")
    
    func testJSONStringEncoder() throws {
        let encoder = JSONStringEncoder()
        let encodedArticle = try encoder.encode(article)
        
        XCTAssertEqual(encodedArticle, "{\"name\":\"jaime\"}")
    }
    
    func testJSONSerializationEncoder() throws {
        let encoder = JSONSerializationEncoder()
        let encodedArticle = try encoder.encode(article) as! [String: String]
        
        XCTAssertEqual(encodedArticle, ["name": "jaime"])
    }
    
    func testEncoderExtension() throws {
        let data = try article.encode()
        let article = try Article.decode(from: data,
                                         using: JSONDecoder())
        
        XCTAssertEqual(article.name, "jaime")
    }
    
    func testEncodableDebugDescription() {
        let json = "{\n  \"name\" : \"jaime\"\n}"

        XCTAssertEqual(article.debugDescription, json)
    }
}
