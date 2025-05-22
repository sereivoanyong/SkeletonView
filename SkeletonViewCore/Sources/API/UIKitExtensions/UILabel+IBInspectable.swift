//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  UILabel+IBInspectable.swift
//
//  Created by Juanpe Catalán on 19/8/21.

import UIKit

public extension UILabel {
    
    @IBInspectable
    var skeletonLineCornerRadius: CGFloat {
        get { return lineCornerStyle.resolved(for: nil) }
        set { lineCornerStyle = newValue < 0 ? .capsule : .fixed(newValue) }
    }
    
    @IBInspectable
    var skeletonLineSpacing: CGFloat {
        get { return lineSpacing.resolved(for: _sk_font) }
        set { lineSpacing = newValue < 0 ? .default : .fixed(newValue) }
    }
    
    @IBInspectable
    var skeletonLastLineFillPercent: Int {
        get { return lastLineFillPercent }
        set { lastLineFillPercent = min(newValue, 100) }
    }
    
}
