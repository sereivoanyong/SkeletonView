//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  UILabel+SKExtensions.swift
//
//  Created by Juanpe Catalán on 23/8/21.

import UIKit

public extension UILabel {
    
    /// Defines the logic for calculating the number of lines of the skeleton.
    /// Default: `inherited`
    var skeletonNumberOfLines: SkeletonNumberOfLines {
        get { _sk_numberOfLines }
        set { _sk_numberOfLines = newValue }
    }
    
    var skeletonLineCornerStyle: SkeletonCornerStyle {
        get { return lineCornerStyle }
        set { lineCornerStyle = newValue }
    }
    
    /// Defines the logic for calculating the height of the skeleton lines.
    /// Default: `SkeletonAppearance.default.textLineHeight`
    var skeletonLineHeight: SkeletonLineHeight {
        get { return lineHeight }
        set { lineHeight = newValue }
    }
    
    /// Defines the skeleton insets.
    var skeletonInsets: NSDirectionalEdgeInsets {
        get { return insets }
        set { insets = newValue }
    }
    
}
