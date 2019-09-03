//
//  KeyedDecodingContainerTests.swift
//  Codable-UtilsTests
//
//  Created by Jaime Andres Laino Guerra on 8/11/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import XCTest
import Codable_Utils

class KeyedDecodingContainerTests: XCTestCase {
    static var allTests = [
        ("testKeyedDecodingContainerDecode", testKeyedDecodingContainerDecode),
    ]
    
    struct Page: Decodable {
        var index: Int
        var title: String
        var content: String?
        
        enum CodingKeys: String, CodingKey {
            case page, title, content
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            index = try container.decode(.page) as Int
            title = try container.decode(.title)
            content = try container.decodeIfPresent(.content)
        }
    }
    
    func testKeyedDecodingContainerDecode() throws {
        let pageDictionary: [String : Any] =
            ["page": 10,
             "title": "TEST"]
        let page = try Page.decode(from: pageDictionary,
                                   using: JSONSerializationDecoder())
        
        XCTAssertEqual(page.index, 10)
        XCTAssertEqual(page.title, "TEST")
        XCTAssertNil(page.content)
    }
}
