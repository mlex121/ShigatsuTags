//
//  AdjustibleRangeExpression.swift
//  ShigatsuTags
//
//  Created by Alexander Lim on 1/6/21.
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

/// Represents range expressions that can be offset by the start index of a collection.
///
/// The primary use for this is shifting ranges to be relative to a slice of a collection.
public protocol AdjustibleRangeExpression: RangeExpression where Bound: SignedInteger {
    /// Adjust this range to match the `startIndex` of the given collection.
    ///
    /// For example, if we take the slice `let slice = [1, 2, 3].suffix(2)`, then
    /// `(0...).adjustingToStartIndex(for: slice) == [1, 2]`.
    ///
    /// - Parameter collection: The collection we're getting the `startIndex` from.
    func adjustingToStartIndex<C>(for collection: C) -> Range<Self.Bound> where C: Collection, Self.Bound == C.Index, Self.Bound.Stride == Self.Bound

    /// Offset the range by `offset`, adjusting its lower and upper bound accordingly.
    /// - Parameter offset: The amount to adjust the range by.
    func advanced(by offset: Bound.Stride) -> Self
}

// MARK: - Default Implementation

public extension AdjustibleRangeExpression where Bound: SignedInteger {
    func adjustingToStartIndex<C>(for collection: C) -> Range<Self.Bound> where C: Collection, Self.Bound == C.Index, Self.Bound.Stride == Self.Bound {
        return advanced(by: collection.startIndex).relative(to: collection)
    }
}

// MARK: - Conformances

extension ClosedRange: AdjustibleRangeExpression where Bound: SignedInteger {}
extension PartialRangeFrom: AdjustibleRangeExpression where Bound: SignedInteger {}
extension PartialRangeThrough: AdjustibleRangeExpression where Bound: SignedInteger {}
extension PartialRangeUpTo: AdjustibleRangeExpression where Bound: SignedInteger {}
extension Range: AdjustibleRangeExpression where Bound: SignedInteger {}

// MARK: - Advancing Ranges

// These extensions are more loosely constrained than `AdjustibleRangeExpression` to allow
// floating point ranges to be advanced.

public extension Range where Bound: Strideable & SignedNumeric {
    func advanced(by offset: Bound.Stride) -> Range<Bound> {
        return type(of: self).init(uncheckedBounds: (lower: lowerBound.advanced(by: offset), upper: upperBound.advanced(by: offset)))
    }
}

public extension ClosedRange where Bound: Strideable & SignedNumeric {
    func advanced(by offset: Bound.Stride) -> ClosedRange<Bound> {
        return type(of: self).init(uncheckedBounds: (lower: lowerBound.advanced(by: offset), upper: upperBound.advanced(by: offset)))
    }
}

public extension PartialRangeFrom where Bound: Strideable & SignedNumeric {
    func advanced(by offset: Bound.Stride) -> PartialRangeFrom<Bound> {
        return type(of: self).init(lowerBound.advanced(by: offset))
    }
}

public extension PartialRangeThrough where Bound: Strideable & SignedNumeric {
    func advanced(by offset: Bound.Stride) -> PartialRangeThrough<Bound> {
        return type(of: self).init(upperBound.advanced(by: offset))
    }
}

public extension PartialRangeUpTo where Bound: Strideable & SignedNumeric {
    func advanced(by offset: Bound.Stride) -> PartialRangeUpTo<Bound> {
        return type(of: self).init(upperBound.advanced(by: offset))
    }
}
