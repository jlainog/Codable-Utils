import XCTest

import Codable_UtilsTests

var tests: [XCTestCaseEntry] = [
    testCase(BundleLoadTests.allTests),
    testCase(DecoderTests.allTests),
    testCase(EncoderTests.allTests),
    testCase(KeyedDecodingContainerTests.allTests),
]
XCTMain(tests)
