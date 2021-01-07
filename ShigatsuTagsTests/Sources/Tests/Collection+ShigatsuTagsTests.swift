//
//  Collection+ShigatsuTagsTests.swift
//  ShigatsuTagsTests
//
//  Created by Alexander Lim on 1/5/21.
//  Copyright 2021 Alexander Lim
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import XCTest
@testable import ShigatsuTags

/// Tests for `subscript(adjustedForStartIndex:)` methods.
final class CollectionShigatsuTagsTests: XCTestCase {
    // MARK: - Test Cases
    
    /// Access a single index.
    func testSingleIndex() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[1...]
        XCTAssertEqual(slice[adjustedForStartIndex: 0], 2)
        XCTAssertEqual(slice[adjustedForStartIndex: 1], 3)
        XCTAssertEqual(slice[adjustedForStartIndex: 2], 4)
        XCTAssertEqual(slice[adjustedForStartIndex: 3], 5)
    }

    /// Access a slice of a suffix.
    func testSuffixSlice() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[1...]
        XCTAssertEqual(slice[adjustedForStartIndex: 1...], [3, 4, 5])
        XCTAssertEqual(slice[adjustedForStartIndex: ...2], [2, 3, 4])
        XCTAssertEqual(slice[adjustedForStartIndex: 4...], [])
    }

    /// Access a slice of a prefix.
    func testPrefixSlice() {
        let array = [1, 2, 3, 4, 5]
        let slice = array[...3]
        XCTAssertEqual(slice[adjustedForStartIndex: 1...], [2, 3, 4])
        XCTAssertEqual(slice[adjustedForStartIndex: ...2], [1, 2, 3])
        XCTAssertEqual(slice[adjustedForStartIndex: 0...], [1, 2, 3, 4])
    }

    /// Ensure the ranges remain the same when accessing the original array.
    func testOriginalArray() {
        let array = [1, 2, 3, 4, 5]
        XCTAssertEqual(array[0], array[adjustedForStartIndex: 0])
        XCTAssertEqual(array[1], array[adjustedForStartIndex: 1])
        XCTAssertEqual(array[2], array[adjustedForStartIndex: 2])
        XCTAssertEqual(array[3], array[adjustedForStartIndex: 3])
        XCTAssertEqual(array[4], array[adjustedForStartIndex: 4])
        XCTAssertEqual(array[0...], array[adjustedForStartIndex: 0...])
        XCTAssertEqual(array[2..<4], array[adjustedForStartIndex: 2..<4])
    }

    /// Mutate individual indices in an array.
    func testMutateSingleIndex() {
        var array = [1, 2, 3, 4, 5]
        var slice = array[1...]

        // Mutate the original array.
        array[adjustedForStartIndex: 0] = 5
        array[adjustedForStartIndex: 1] = 4
        array[adjustedForStartIndex: 2] = 3
        array[adjustedForStartIndex: 3] = 2
        array[adjustedForStartIndex: 4] = 1
        XCTAssertEqual(array, [5, 4, 3, 2, 1])
        XCTAssertEqual(slice, [2, 3, 4, 5])

        // Mutate the slice.
        slice[adjustedForStartIndex: 0] = 5
        slice[adjustedForStartIndex: 1] = 4
        slice[adjustedForStartIndex: 2] = 3
        slice[adjustedForStartIndex: 3] = 2
        XCTAssertEqual(slice, [5, 4, 3, 2])
    }

    /// Mutate ranges in an array.
    func testMutateRange() {
        var array = [1, 2, 3, 4, 5]
        var slice = array[1...]

        // Mutate the original array.
        array[adjustedForStartIndex: 1...3] = [7, 8, 9]
        XCTAssertEqual(array, [1, 7, 8, 9, 5])
        array[adjustedForStartIndex: ...2] = [0, 1, 2]
        XCTAssertEqual(array, [0, 1, 2, 9, 5])

        // Mutate the slice.
        slice[adjustedForStartIndex: 0...2] = [9, 8, 7]
        XCTAssertEqual(slice, [9, 8, 7, 5])
        slice[adjustedForStartIndex: 3...] = []
        XCTAssertEqual(slice, [9, 8, 7])
    }
}
