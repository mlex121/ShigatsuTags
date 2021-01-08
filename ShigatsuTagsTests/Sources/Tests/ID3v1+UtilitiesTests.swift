//
//  ID3v1+UtilitiesTests.swift
//  ShigatsuTagsTests
//
//  Created by Alexander Lim on 1/8/21.
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

/// Test the utilities in `ID3v1+Utilities.swift`.
final class ID3v1UtilitiesTests: XCTestCase {
    // MARK: - Test Cases (Parsing)

    /// Parse an ordinary ID3v1 field string.
    func testParseNormalID3v1String() {
        let data = "Test".data(using: ID3v1.defaultEncoding)! + Data(repeating: 0, count: 26)
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse ordinary ID3v1 string")
            return
        }
        XCTAssertEqual(string, "Test")
    }

    /// Parse an ID3v1 field string without any zero bytes.
    func testParseID3v1StringWithNoZeroBytes() {
        let data = "TestNoNulls".data(using: ID3v1.defaultEncoding)!
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse ID3v1 string without zero bytes")
            return
        }
        XCTAssertEqual(string, "TestNoNulls")
    }

    /// Parse an ID3v1 field string with data after the zeros.
    func testParseID3v1StringWithDataAfterZeros() {
        let data = "TestDataAfterZeros\0\0\0\0\0\0\0extra".data(using: ID3v1.defaultEncoding)!
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse ID3v1 string without zero bytes")
            return
        }
        // We should ignore the data after the zeros, to keep in line with most tag reading
        // libraries.
        XCTAssertEqual(string, "TestDataAfterZeros")
    }

    /// Parse an ID3v1 field string with only zeros.
    func testParseID3v1StringWithAllZeros() {
        let data = Data(repeating: 0, count: 30)
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse ID3v1 string with only zero bytes")
            return
        }
        STAssertEmptyCollection(string)
    }

    /// Parse an empty ID3v1 field string.
    func testParseEmptyID3v1String() {
        let data = Data()
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse an empty ID3v1 string")
            return
        }
        STAssertEmptyCollection(string)
    }

    /// Parse an ID3v1 field string with data, then zeros, then data, then zeros.
    func testParseID3v1StringWithDataSandwichedInZeros() {
        let data = "TestData\0\0\0moredata\0\0\0\0\0\0".data(using: ID3v1.defaultEncoding)!
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse an ID3v1 string with data sandwiched in zeros")
            return
        }
        XCTAssertEqual(string, "TestData")
    }

    /// Parse an ID3v1 field string with data, then whitespace, then zeros.
    func testParseID3v1StringWithWhiteSpacePaddingBeforeZeroPadding() {
        let data = "TestDataBeforeWhitespace    \n\r\n\0\0\0\0\0\0".data(using: ID3v1.defaultEncoding)!
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse an ID3v1 string with whitespace padding")
            return
        }
        XCTAssertEqual(string, "TestDataBeforeWhitespace")
    }

    /// Parse an ID3v1 field string with data then only whitespace.
    func testParseID3v1StringWithOnlyWhiteSpacePadding() {
        let data = "TestDataBeforeWhitespace    \n\r\n  ".data(using: ID3v1.defaultEncoding)!
        guard let string = data.parseID3v1String(using: ID3v1.defaultEncoding) else {
            XCTFail("Failed to parse an ID3v1 string with whitespace padding")
            return
        }
        XCTAssertEqual(string, "TestDataBeforeWhitespace")
    }
}
