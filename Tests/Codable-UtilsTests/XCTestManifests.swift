import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BundleLoadTests.allTests),
        testCase(DecoderTests.allTests),
        testCase(EncoderTests.allTests),
        testCase(KeyedDecodingContainerTests.allTests),
    ]
}
#endif
