//
//  ID3v1Tests.swift
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

class ID3v1Tests: XCTestCase {
    // MARK: - Test Cases

    /// Deserialize valid, empty tag data.
    func testDeserializeEmptyTag() {
        guard let tag = ID3v1(Constant.emptyTagData) else {
            XCTFail("Failed to de-serialize empty tag")
            return
        }
        XCTAssertEqual(tag.fields, Constant.emptyTagFields)
        XCTAssertEqual(tag.data, Constant.emptyTagData)
        XCTAssertEqual(tag.data.count, 128)
        XCTAssertEqual(tag.encoding, ID3v1.defaultEncoding)
    }

    /// Serialize a tag with all empty fields.
    func testSerializeEmptyTag() {
        guard let tag = ID3v1(Constant.emptyTagFields) else {
            XCTFail("Failed to serialize empty tag")
            return
        }
        XCTAssertEqual(tag.fields, Constant.emptyTagFields)
        XCTAssertEqual(tag.data, Constant.emptyTagData)
        XCTAssertEqual(tag.data.count, 128)
        XCTAssertEqual(tag.encoding, ID3v1.defaultEncoding)
    }

    /// Deserialize a full tag with all fields present.
    func testDeserializeFullTag() {
        let encoding = ID3v1.defaultEncoding
        let data = Constant.fullTagData(using: encoding)
        guard let tag = ID3v1(Constant.fullTagData(using: encoding)) else {
            XCTFail("Failed to deserialize a full tag")
            return
        }
        XCTAssertEqual(tag.fields, Constant.fullTagFields)
        XCTAssertEqual(tag.data, data)
        XCTAssertEqual(tag.data.count, 128)
        XCTAssertEqual(tag.encoding, encoding)
    }

    /// Serialize a full tag with all fields present.
    func testSerializeFullTag() {
        let encoding = ID3v1.defaultEncoding
        guard let tag = ID3v1(Constant.fullTagFields) else {
            XCTFail("Failed to serialize a full tag")
            return
        }
        XCTAssertEqual(tag.fields, Constant.fullTagFields)
        XCTAssertEqual(tag.data, Constant.fullTagData(using: encoding))
        XCTAssertEqual(tag.data.count, 128)
        XCTAssertEqual(tag.encoding, encoding)
    }

    /// Deserialize a tag with an invalid header.
    func testDeserializeInvalidHeader() {
        var invalidTagData = Constant.emptyTagData
        // Overwrite the header.
        invalidTagData.overwriteData(startingAtIndex: 0, with: "BAG", using: .ascii)
        XCTAssertNil(ID3v1(invalidTagData), "We should not be able to deserialize an ID3v1 tag with an invalid header")
    }

    /// Deserialize a tag that's too large or small.
    func testDeserializeInvalidSize() {
        let longerTagData = Constant.emptyTagData + CollectionOfOne(0)
        XCTAssertNil(ID3v1(longerTagData), "We should not be able to deserialize an ID3v1 tag that's too long")

        let shorterTagData = Constant.emptyTagData.prefix(127)
        XCTAssertNil(ID3v1(shorterTagData), "We should not be able to deserialize an ID3v1 tag that's too short")
    }

    /// Deserialize a tag that has data before it.
    func testDeserializeTagWithDataBeforeIt() {
        let encoding = ID3v1.defaultEncoding
        let data = Data(repeating: 0, count: 50) + Constant.fullTagData(using: encoding)
        guard let tag = ID3v1(data, using: encoding) else {
            XCTFail("We should be able to deserialize a tag with data before it")
            return
        }
        XCTAssertEqual(tag.fields, Constant.fullTagFields)
        XCTAssertEqual(tag.data, data.suffix(128))
        XCTAssertEqual(tag.data.count, 128)
        XCTAssertEqual(tag.encoding, encoding)
    }
}

// MARK: - Constants

private extension ID3v1Tests {
    enum Constant {
        /// A valid but empty ID3v1 tag.
        static let emptyTagData = "TAG".data(using: .ascii)! + Data(repeating: 0, count: 125)

        /// The fields that match `emptyTagData`.
        static let emptyTagFields = ID3v1.Fields(title: "", artist: "", album: "", year: "", comment: "", genre: ID3v1.Genre(rawValue: 0)) // `blues` is genre 0.

        /// A fully filled set of fields.
        static let fullTagFields = ID3v1.Fields(title: "Title", artist: "Artist", album: "Album", year: "2000", comment: "Comment", genre: .hipHop)

        /// Serializes an ID3v1 tag matching `fullTagFields` using the given encoding.
        /// - Parameter encoding: The encoding to serialize the fields with.
        static func fullTagData(using encoding: String.Encoding) -> Data {
            var data = Constant.emptyTagData
            data.overwriteData(startingAtIndex: 3, with: fullTagFields.title, using: encoding)
            data.overwriteData(startingAtIndex: 33, with: fullTagFields.artist, using: encoding)
            data.overwriteData(startingAtIndex: 63, with: fullTagFields.album, using: encoding)
            data.overwriteData(startingAtIndex: 93, with: fullTagFields.year, using: encoding)
            data.overwriteData(startingAtIndex: 97, with: fullTagFields.comment, using: encoding)
            data[127] = fullTagFields.genre.rawValue
            return data
        }
    }
}

