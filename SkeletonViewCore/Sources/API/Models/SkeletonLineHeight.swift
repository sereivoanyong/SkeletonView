//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  SkeletonLineHeight.swift
//
//  Created by Juanpe Catalán on 22/11/21.

import UIKit

public enum SkeletonLineHeight: Equatable {

    case `default`

    /// Calculates the line height based on the font line height.
    case relativeToFont(_ keyPath: KeyPath<UIFont, CGFloat> = \.lineHeight)
    
    /// Calculates the line height based on the height constraints.
    ///
    /// If no constraints exist, the height will be set to the `lineHeight`
    /// value defined in the `SkeletonAppearance`.
    case relativeToConstraints
    
    /// Returns the specific height specified as the associated value.
    case fixed(CGFloat)
    
}
