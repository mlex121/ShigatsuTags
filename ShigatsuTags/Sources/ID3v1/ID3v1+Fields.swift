//
//  ID3v1+Fields.swift
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

public extension ID3v1 {
    /// The fields that make up an ID3v1 tag.
    public struct Fields: Hashable {
        /// The title of the song.
        /// - Note: This field is 30 bytes.
        public var title: String

        /// The artist.
        /// - Note: This field is 30 bytes.
        public var artist: String

        /// The album the song is on.
        /// - Note: This field is 30 bytes.
        public var album: String

        /// The year the song was released.
        /// - Note: This field is 4 bytes.
        public var year: String

        /// A field for any extra info.
        /// - Note: This field is 30 bytes.
        public var comment: String

        /// The genre of the song.
        /// - Note: This field is 1 byte.
        public var genre: Genre
    }
}
