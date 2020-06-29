import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TokamakDocsTests.allTests),
    ]
}
#endif
