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
        ("testDecodeEncodeDictionary", testDecodeEncodeDictionary)
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
    
    struct Photo: Codable {
        enum URLKind: String, CodingKey {
            case raw, full, regular, small, thumb
        }
        enum CodingKeys: String, CodingKey {
            case urls
        }
        
        let urls: [URLKind: String]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            urls = try container.decodeDictionary(.urls)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeDictionary(urls, forKey: .urls)
        }
    }
    
    func testDecodeEncodeDictionary() throws {
        let json = ["urls": ["raw": "https://images.raw",
                                  "full": "https://images.full",
                                  "regular": "https://images.regular",
                                  "small": "https://images.small",
                                  "thumb": "https://images.thumb"]
        ]
        let photo = try Photo.decode(from: json, using: JSONSerializationDecoder())
        let dictionary = try photo.encode(using: JSONSerializationEncoder()) as! [String: [String: String]]
        XCTAssertEqual(json, dictionary)
    }
}
