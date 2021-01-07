//
//  AdjustibleRangeExpressionTests.swift
//  ShigatsuTagsTests
//
//  Created by Alexander Lim on 1/6/21.
//  Copyright © 2021 Alexander Lim. All rights reserved.
//

import XCTest
@testable import ShigatsuTags

/// Tests for `AdjustibleRangeExpression`.
final class AdjustibleRangeExpressionTests: XCTestCase {
    // MARK: - Test Cases (Adjustment Methods)

    /// Test `Range.adjustedByStartIndex(by:)`.
    func testRangeAdjustedByStartIndex() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[1...]
        STAssertElementsEqual((1..<3).adjustingToStartIndex(for: slice), [2, 3])
    }

    /// Test `ClosedRange.adjustedByStartIndex(by:)`.
    func testClosedRangeAdjustedByStartIndex() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[1...]
        STAssertElementsEqual((1...3).adjustingToStartIndex(for: slice), [2, 3, 4])
    }

    /// Test `PartialRangeFrom.adjustedByStartIndex(by:)`.
    func testPartialRangeFromAdjustedByStartIndex() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[1...]
        STAssertElementsEqual((1...).adjustingToStartIndex(for: slice), [2, 3, 4])
    }

    /// Test `PartialRangeThrough.adjustedByStartIndex(by:)`.
    func testPartialRangeThroughAdjustedByStartIndex() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[1...]
        STAssertElementsEqual((...2).adjustingToStartIndex(for: slice), [1, 2, 3])
    }

    /// Test `PartialRangeUpTo.adjustedByStartIndex(by:)`.
    func testPartialRangeUpToAdjustedByStartIndex() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[1...]
        STAssertElementsEqual((..<2).adjustingToStartIndex(for: slice), [1, 2])
    }

    // MARK: - Test Cases (Advancement Methods)

    /// Test `Range.advanced(by:)`.
    func testRangeAdvancedByOffset() {
        let integerRange = 1..<5
        XCTAssertEqual(integerRange.advanced(by: 0), 1..<5)
        XCTAssertEqual(integerRange.advanced(by: 2), 3..<7)
        XCTAssertEqual(integerRange.advanced(by: -4), -3..<1)
        let floatingPointRange = 1.0..<5.5
        XCTAssertEqual(floatingPointRange.advanced(by: 0), 1.0..<5.5)
        XCTAssertEqual(floatingPointRange.advanced(by: 2.1), 3.1..<7.6)
        XCTAssertEqual(floatingPointRange.advanced(by: -4.5), -3.5..<1.0)
    }

    /// Test `ClosedRange.advanced(by:)`.
    func testClosedRangeAdvancedByOffset() {
        let integerRange = 0...10
        XCTAssertEqual(integerRange.advanced(by: 0), 0...10)
        XCTAssertEqual(integerRange.advanced(by: 5), 5...15)
        XCTAssertEqual(integerRange.advanced(by: -1), -1...9)
        let floatingPointRange = 0.0...10.25
        XCTAssertEqual(floatingPointRange.advanced(by: 0), 0...10.25)
        XCTAssertEqual(floatingPointRange.advanced(by: 4.5), 4.5...14.75)
        XCTAssertEqual(floatingPointRange.advanced(by: -1.25), -1.25...9)
    }

    /// Test `PartialRangeFrom.advanced(by:)`.
    func testPartialRangeFromAdvancedByOffset() {
        let integerRange = 1...
        XCTAssertEqual(integerRange.advanced(by: 0).lowerBound, 1)
        XCTAssertEqual(integerRange.advanced(by: 10).lowerBound, 11)
        XCTAssertEqual(integerRange.advanced(by: -3).lowerBound, -2)
        let floatingPointRange = 2.125...
        XCTAssertEqual(floatingPointRange.advanced(by: 0).lowerBound, 2.125)
        XCTAssertEqual(floatingPointRange.advanced(by: 1.125).lowerBound, 3.25)
        XCTAssertEqual(floatingPointRange.advanced(by: -3.5).lowerBound, -1.375)
    }

    /// Test `PartialRangeThrough.advanced(by:)`.
    func testPartialRangeThroughAdvancedByOffset() {
        let integerRange = ...6
        XCTAssertEqual(integerRange.advanced(by: 0).upperBound, 6)
        XCTAssertEqual(integerRange.advanced(by: 2).upperBound, 8)
        XCTAssertEqual(integerRange.advanced(by: -4).upperBound, 2)
        let floatingPointRange = ...6.5
        XCTAssertEqual(floatingPointRange.advanced(by: 0).upperBound, 6.5)
        XCTAssertEqual(floatingPointRange.advanced(by: 1.5).upperBound, 8)
        XCTAssertEqual(floatingPointRange.advanced(by: -0.25).upperBound, 6.25)
    }

    /// Test `PartialRangeUpTo.advanced(by:)`.
    func testPartialRangeUpToAdvancedByOffset() {
        let integerRange = ..<1
        XCTAssertEqual(integerRange.advanced(by: 0).upperBound, 1)
        XCTAssertEqual(integerRange.advanced(by: 1).upperBound, 2)
        XCTAssertEqual(integerRange.advanced(by: -10).upperBound, -9)
        let floatingPointRange = ..<0.75
        XCTAssertEqual(floatingPointRange.advanced(by: 0).upperBound, 0.75)
        XCTAssertEqual(floatingPointRange.advanced(by: 0.25).upperBound, 1.0)
        XCTAssertEqual(floatingPointRange.advanced(by: -0.75).upperBound, 0.0)
    }
}
