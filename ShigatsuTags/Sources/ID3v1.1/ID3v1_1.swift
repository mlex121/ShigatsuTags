//
//  ID3v1_1.swift
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

/// An ID3v1.1 tag.
///
/// Note that all the fields in ID3v1 have maximum lengths. The serialized ID3v1.1 tag is a fixed
/// 128 bytes long.
public struct ID3v1_1 {
    // MARK: - Stored Properties

    /// The human-readable fields that make up the tag.
    ///
    /// This is a separate struct so we can compare it directly for equality, rather than having an
    /// `Equatable` comparison take into account `data` and `encoding`.
    public let fields: Fields

    /// The serialized ID3v1.1 tag.
    ///
    /// If this tag was initialized with binary data, this is a copy of that data. If this tag was
    /// initialized with the individual fields, then this will be serialized from those fields on
    /// initialization.
    public let data: Data

    /// How the string-based fields (everything except `genre`) are encoded.
    ///
    /// This is passed when we initially deserialize the tag and is necessary to ensure we don't
    /// go over the size limits of each field.
    public let encoding: String.Encoding

    /// Initialize an ID3v1.1 tag by deserializing it from a media file.
    ///
    /// This attempts to read an ID3v1.1 tag from the end of a file. If the format is invalid, this
    /// will return `nil`.
    ///
    /// The default encoding for tag fields is UTF-8. The ID3v1.1 specification does not state what
    /// encoding to use for anything except the header, so you may pass an alternative encoding if
    /// you'd like.
    ///
    /// - Parameters:
    ///   - data: The data to deserialize from.
    ///   - encoding: The encoding to use when reading and writing string-based fields.
    public init?(_ data: Data, using encoding: String.Encoding = defaultEncoding) {
        // The tag exists at the last 128 bytes of the file.
        let tagData = data.suffix(Constant.tagSize)
        guard tagData.count == Constant.tagSize else { return nil }

        // ID3v1.1 tags start with the bytes "TAG".
        guard tagData[adjustedForStartIndex: ByteRange.header] == Constant.header else { return nil }

        guard let title = tagData[adjustedForStartIndex: ByteRange.title].parseID3v1String(using: encoding) else { return nil }
        guard let artist = tagData[adjustedForStartIndex: ByteRange.artist].parseID3v1String(using: encoding) else { return nil }
        guard let album = tagData[adjustedForStartIndex: ByteRange.album].parseID3v1String(using: encoding) else { return nil }
        guard let year = tagData[adjustedForStartIndex: ByteRange.year].parseID3v1String(using: encoding) else { return nil }

        // The comment is handled in a special way compared to ID3v1 tags:
        //     - If the second-last byte of the comment is 0 and the last byte is not, read the last
        //       byte as `trackNumber` and shorten `comment` to 28 bytes.
        //     - Otherwise, treat comment as 30 bytes long.
        let commentByteRange: ClosedRange<Int>
        let trackNumber: UInt8?

        if tagData[adjustedForStartIndex: ByteIndex.trackNumberValidity] == 0
            && tagData[adjustedForStartIndex: ByteIndex.trackNumber] != 0 {
            commentByteRange = ByteRange.commentShortened
            trackNumber = tagData[adjustedForStartIndex: ByteIndex.trackNumber]
        } else {
            commentByteRange = ByteRange.commentFull
            trackNumber = nil
        }

        guard let comment = tagData[adjustedForStartIndex: commentByteRange].parseID3v1String(using: encoding) else { return nil }
        // Genre is always 1 byte.
        let genre = ID3v1.Genre(rawValue: tagData[adjustedForStartIndex: ByteIndex.genre])

        fields = Fields(title: title, artist: artist, album: album, year: year, comment: comment, trackNumber: trackNumber, genre: genre)
        self.data = tagData
        self.encoding = encoding
    }

    /// Initialize an ID3v1.1 tag from a set of fields.
    ///
    /// This initializer checks the encoded sizes of each of the fields to ensure we don't
    /// exceed the maximum sizes specified by the ID3v1.1 spec.
    ///
    /// If any tags would be too large to write into an ID3v1.1 tag, this initializer returns `nil`.
    ///
    /// - Parameters:
    ///   - fields: The values of each field in the tag.
    ///   - encoding: The encoding to use when reading and writing string-based fields.
    public init?(_ fields: Fields, using encoding: String.Encoding = defaultEncoding) {
        self.fields = fields

        // Serialize the ID3v1.1 tag.
        var data = Data(capacity: Constant.tagSize)
        data.append(contentsOf: Constant.header)

        // Ensure we can serialize each field within its maximum size using the given encoding.

        guard let titleData = ID3v1.serialize(tag: fields.title, using: encoding, length: ByteRange.title.count) else { return nil }
        data.append(titleData)

        guard let artistData = ID3v1.serialize(tag: fields.artist, using: encoding, length: ByteRange.artist.count) else { return nil }
        data.append(artistData)

        guard let albumData = ID3v1.serialize(tag: fields.album, using: encoding, length: ByteRange.album.count) else { return nil }
        data.append(albumData)

        guard let yearData = ID3v1.serialize(tag: fields.year, using: encoding, length: ByteRange.year.count) else { return nil }
        data.append(yearData)

        // Comment length depends on whether we have a track number or not.
        if let trackNumber = fields.trackNumber {
            // Track number can't be 0, since that's equivalent to having another 0 byte at the end of a 30-byte comment.
            guard trackNumber != 0 else { return nil }

            // We have a track number, so shorten the comment by 2 bytes, add a 0, then add the track number.
            guard let commentData = ID3v1.serialize(tag: fields.comment, using: encoding, length: ByteRange.commentShortened.count) else { return nil }
            data.append(commentData)
            data.append(0)
            data.append(trackNumber)
        } else {
            // We don't have a track number, so just write a 30-byte comment.
            guard let commentData = ID3v1.serialize(tag: fields.comment, using: encoding, length: ByteRange.commentFull.count) else { return nil }
            data.append(commentData)
        }

        let genreData = Data(byte: fields.genre.rawValue)
        data.append(genreData)

        assert(data.count == Constant.tagSize)
        self.data = data

        self.encoding = encoding
    }

    /// Initialize an ID3v1 tag from its individual fields.
    ///
    /// This initializer checks the encoded sizes of each of the fields to ensure we don't
    /// exceed the maximum sizes specified by the ID3v1 spec.
    ///
    /// If any tags would be too large to write into an ID3v1 tag, this initializer returns `nil`.
    ///
    /// This is a convenience initializer to `init(_:using:)`.
    ///
    /// - Parameters:
    ///   - title: The title.
    ///   - artist: The artist.
    ///   - album: The album.
    ///   - year: The year.
    ///   - comment: The comment.
    ///   - trackNumber: The track number. Optional.
    ///   - genre: The genre.
    ///   - encoding: The encoding to use when reading and writing string-based fields.
    public init?(title: String, artist: String, album: String, year: String, comment: String, trackNumber: UInt8?, genre: ID3v1.Genre, using encoding: String.Encoding = defaultEncoding) {
        self.init(Fields(title: title, artist: artist, album: album, year: year, comment: comment, trackNumber: trackNumber, genre: genre), using: encoding)
    }
}

public extension ID3v1_1 {
    /// The default encoding to use when reading and writing ID3v1.1 tags.
    ///
    /// We defer to the main ID3v1 choice.
    ///
    /// - See: `ID3v1.defaultEncoding`
    static let defaultEncoding = ID3v1.defaultEncoding
}

private extension ID3v1_1 {
    /// Private constants.
    enum Constant {
        /// The size of an ID3v1.1 tag at the end of a file.
        static let tagSize = 128

        /// The header at the start of an ID3v1.1 tag.
        static let header = "TAG".data(using: .ascii)!
    }

    /// Specific byte ranges in ID3v1.1 tag data.
    enum ByteRange {
        /// The location of the header.
        static let header = 0...2

        /// The location of the title.
        static let title = 3...32

        /// The location of the artist.
        static let artist = 33...62

        /// The location of the album.
        static let album = 63...92

        /// The location of the year.
        static let year = 93...96

        /// The location of the comment, if it takes up the full 30 bytes.
        static let commentFull = 97...126

        /// The location of the comment, if it only takes up 28 bytes.
        static let commentShortened = 97...124
    }

    /// Specific byte indices in ID3v1.1 tag data.
    enum ByteIndex {
        /// If this byte is 0, we should read the track number.
        static let trackNumberValidity = 125

        /// The location of the track number, if it's valid.
        static let trackNumber = 126

        /// The location of the genre.
        static let genre = 127
    }
}
