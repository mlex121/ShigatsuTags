//
//  Collection+ShigatsuTags.swift
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

public extension Collection where Index: SignedInteger {
    /// Accesses the element at the specified position, adjusted for `startIndex`.
    /// - Parameter index: The index, relative to the current slice.
    public subscript(adjustedForStartIndex index: Index) -> Element {
        return self[index + startIndex]
    }

    /// Accesses the subsequence at the specified range, adjusted for `startIndex`.
    /// - Parameter range: A range for slicing the collection, relative to the current slice.
    public subscript<R>(adjustedForStartIndex range: R) -> SubSequence
        where R: AdjustibleRangeExpression, Index == R.Bound, Index.Stride == Index {
            return self[range.adjustingToStartIndex(for: self)]
    }
}

public extension MutableCollection where Index: SignedInteger {
    /// Accesses the element at the specified position, adjusted for `startIndex`.
    /// - Parameter index: The index, relative to the current slice.
    public subscript(adjustedForStartIndex index: Index) -> Element {
        get {
            return self[index + startIndex]
        }
        set(newValue) {
            self[index + startIndex] = newValue
        }
    }

    /// Accesses the subsequence at the specified range, adjusted for `startIndex`.
    /// - Parameter range: A range for slicing the collection, relative to the current slice.
    public subscript<R>(adjustedForStartIndex range: R) -> SubSequence
        where R: AdjustibleRangeExpression, Index == R.Bound, Index.Stride == Index {
        get {
            return self[range.adjustingToStartIndex(for: self)]
        }
        set(newValue) {
            self[range.adjustingToStartIndex(for: self)] = newValue
        }
    }
}
