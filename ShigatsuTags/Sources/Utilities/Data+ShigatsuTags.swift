//
//  Data+ShigatsuTags.swift
//  ShigatsuTags
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

import Foundation

public extension Data {
    /// Initialize `Data` from a single byte.
    init(byte: UInt8) {
        self.init(CollectionOfOne(byte))
    }
}
