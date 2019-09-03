//
//  BundleLoadTests.swift
//  Codable-UtilsTests
//
//  Created by Jaime Andres Laino Guerra on 8/11/19.
//  Copyright © 2019 jaime Laino Guerra. All rights reserved.
//

import XCTest
import Codable_Utils

struct Name: Codable {
    let first: String
    let last: String
}
struct Friend: Codable {
    let id: Int
    let name: String
}
struct Mock: Codable {
    let index: Int
    let guid: String
    let name: Name
    let email: String
    let tags: [String]
    let range: [Int]
    let friends: [Friend]
}

class BundleLoadTests: XCTestCase {
    
    static var allTests = [
        ("testLoadFromBundle", testLoadFromBundle),
    ]
    
    // Test Disable: Currently resources are not supported in SPM
    func testLoadFromBundle() throws {
//        let fileName = "mock.json"
//        let bundle = Bundle.init(for: BundleLoadTests.self)
//
//        let data = try bundle.load(fileName)
//        let explicitMock = try bundle.load(fileName, using: JSONDecoder(), as: Mock.self)
//        let inferedMock = try bundle.load(fileName, using: JSONDecoder()) as Mock
//
//        XCTAssertNotNil(data)
//        XCTAssertEqual(explicitMock.index, 0)
//        XCTAssertEqual(inferedMock.email, "carissa.mcbride@isotronic.co.uk")
//        XCTAssertThrowsError(try bundle.load("mock"))
    }
}
