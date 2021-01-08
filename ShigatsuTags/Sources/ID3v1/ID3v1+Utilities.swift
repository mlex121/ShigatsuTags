//
//  ID3v1+Utilities.swift
//  ShigatsuTags
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

import Foundation

// MARK: - Serialization Utilities

extension ID3v1 {
    /// Serialize a single field, checking for maximum length and padding if necessary.
    ///
    /// This can be used for serializing both ID3v1 and ID3v1.1 fields.
    static func serialize(tag: String, using encoding: String.Encoding, length: Int) -> Data? {
        // Verify conversion and that we don't exceed the length.
        guard let data = tag.data(using: encoding),
            data.count <= length
            else { return nil }
        // Pad the rest of the length out.
        return data.rightPaddedWithZeros(resultingLength: length)
    }
}

// MARK: - Data Utilities

extension Data {
    /// Generate the string for a tag with the given encoding.
    ///
    /// This method strips any trailing padding zeros.
    func id3v1TagString(using encoding: String.Encoding) -> String? {
        // Ignore the padding and attempt string conversion.
        return String(bytes: prefix(upTo: startIndexOfID3v1ZeroPadding()), encoding: encoding)
    }

    /// Finds the starting index of zero-padding in the ID3v1 tag data.
    ///
    /// If there is no padding, this will return `endIndex`. If there is no data, i.e. all padding,
    /// this will return `endIndex`.
    func startIndexOfID3v1ZeroPadding() -> Index {
        guard let reversedIndex = reversed().firstIndex(where: { $0 != 0 }) else {
            // The data is entirely zeros.
            return startIndex
        }
        // `reversedIndex.base` points to the position _after_ the last data byte in the tag, i.e.
        // the first padding byte.
        return reversedIndex.base
    }

    /// Right-pads the data with zeros until the data is the specified length.
    ///
    /// This is necessary when serializing ID3v1 tags.
    ///
    /// If `length` > `count`, this method returns the original data.
    func rightPaddedWithZeros(resultingLength: Int) -> Data {
        let paddingLength = resultingLength - count
        // Nothing to do.
        guard paddingLength > 0 else { return self }
        return self + Data(repeating: 0, count: paddingLength)
    }
}
