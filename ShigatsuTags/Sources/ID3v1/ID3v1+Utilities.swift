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
    /// Parse a string from an ID3v1-type field using the given encoding.
    ///
    /// This method strips zero-padding from the end by stripping from the first zero-byte onwards. In effect, we read the string like it's a null-terminated C-string.
    ///
    /// This method also strips trailing
    func parseID3v1String(using encoding: String.Encoding) -> String? {
        let indexOfFirstZeroByte = firstIndex(of: 0)
        let beforeFirstZeroByte = prefix(upTo: indexOfFirstZeroByte ?? endIndex)

        // Encode first.
        guard let string = String(bytes: beforeFirstZeroByte, encoding: encoding) else {
            return nil
        }

        // The implementations I've seen online strip whitespace from both sides. I think this is
        // because WinAmp pads with whitespace, unsure.
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
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
