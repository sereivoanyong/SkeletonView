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
        get { return _sk_lineCornerStyle.resolved(for: nil) }
        set { _sk_lineCornerStyle = newValue < 0 ? .capsule : .fixed(newValue) }
    }
    
    @IBInspectable
    var skeletonLineSpacing: CGFloat {
        get { return _sk_lineSpacing.resolved(for: _sk_font) }
        set { _sk_lineSpacing = newValue < 0 ? .default : .fixed(newValue) }
    }
    
    @IBInspectable
    var skeletonLastLineFillPercent: CGFloat {
        get { return _sk_lastLineFillPercent }
        set { _sk_lastLineFillPercent = min(max(newValue, 0), 1) }
    }
    
}
