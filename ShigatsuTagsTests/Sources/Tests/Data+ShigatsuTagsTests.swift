//
//  Data+ShigatsuTagsTests.swift
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

/// Test the extension methods in `Data+ShigatsuTags.swift`.
final class DataShigatsuTagsTests: XCTestCase {
    // MARK: - Test Cases

    /// Iterate through all byte values and ensure they're correct.
    func testAllValeus() {
        for byte in (UInt8.min)...(UInt8.max) {
            let data = Data(byte: byte)
            guard let convertedBack = data.first else {
                XCTFail("We got empty data back from converting \(byte)")
                return
            }
            XCTAssertEqual(data.count, 1, "We should only have converted \(byte) into one byte, but instead got \(data)")
            XCTAssertEqual(convertedBack, byte)
        }
    }
}
