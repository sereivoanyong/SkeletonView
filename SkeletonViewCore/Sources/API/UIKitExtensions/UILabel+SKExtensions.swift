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
    
    var skeletonLineCornerStyle: SkeletonCornerStyle {
        get { return _sk_lineCornerStyle }
        set { _sk_lineCornerStyle = newValue }
    }
    
    /// Defines the logic for calculating the height of the skeleton lines.
    /// Default: `SkeletonAppearance.default.textLineHeight`
    var skeletonLineHeight: SkeletonLineHeight {
        get { return _sk_lineHeight }
        set { _sk_lineHeight = newValue }
    }
    
    var skeletonLineSpacing: SkeletonLineSpacing {
        get { return _sk_lineSpacing }
        set { _sk_lineSpacing = newValue }
    }
    
    /// Defines the skeleton insets.
    var skeletonInsets: NSDirectionalEdgeInsets {
        get { return _sk_insets }
        set { _sk_insets = newValue }
    }
    
}
