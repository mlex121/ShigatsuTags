//
//  TestUtilities.swift
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

// MARK: - Assertions

/// Asserts that the given collection is empty.
func STAssertEmptyCollection<T>(_ collection: @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T: Collection {
    try XCTAssertTrue(collection().isEmpty, message(), file: file, line: line)
}

/// Asserts that the two sequences are equal.
func STAssertElementsEqual<S1, S2>(_ lhs: @autoclosure () -> S1, _ rhs: @autoclosure () -> S2, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where S1: Sequence, S2: Sequence, S1.Element == S2.Element, S1.Element: Equatable {
    let lhsElements = lhs()
    let rhsElements = rhs()
    XCTAssertTrue(lhsElements.elementsEqual(rhsElements), "\(lhsElements) does not match \(rhsElements): \(message())", file: file, line: line)
}

// MARK: - Data Utilities

extension Data {
    /// Overwrite the data starting at the given index with the given string.
    ///
    /// Since this is a test method, we assume the string can be encoded with the given encoding.
    mutating func overwriteData(startingAtIndex index: Int, with string: String, using encoding: String.Encoding) {
        let data = string.data(using: encoding)!
        let rangeEnd = index + data.count
        self[index..<rangeEnd] = data
    }
}
