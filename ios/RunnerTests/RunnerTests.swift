import Flutter
import UIKit
import XCTest

class RunnerTests: XCTestCase {

    func testExample() {
        // This is an example of a functional test case.
        XCTAssertTrue(true, "This test always passes.")
    }

    func testAddition() {
        // This is an example of a simple addition test.
        let sum = addNumbers(2, 3)
        XCTAssertEqual(sum, 5, "Expected 2 + 3 to equal 5")
    }

    func addNumbers(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}
