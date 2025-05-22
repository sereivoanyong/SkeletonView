//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  SkeletonExtended.swift
//
//  Created by Juanpe Catalán on 23/8/21.

import Foundation

/// Type that acts as a generic extension point for all `SkeletonViewExtended` types.
public struct SkeletonViewExtension<ExtendedType: AnyObject> {
    /// Stores the type or meta-type of any extended type.
    public let type: ExtendedType

    /// Create an instance from the provided value.
    ///
    /// - Parameter type: Instance being extended.
    @inlinable
    public init(_ type: ExtendedType) {
        self.type = type
    }
}

/// Protocol describing the `sk` extension points for SkeletonView extended types.
@_marker public protocol SkeletonViewExtended: AnyObject {
}

extension SkeletonViewExtended {
    /// Instance SkeletonView extension point.
    public var sk: SkeletonViewExtension<Self> {
        SkeletonViewExtension(self)
    }
}
