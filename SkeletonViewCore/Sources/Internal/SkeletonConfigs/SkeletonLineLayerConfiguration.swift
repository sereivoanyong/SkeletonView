//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  SkeletonLineLayerConfiguration.swift
//
//  Created by Juanpe Catalán on 18/8/21.

import UIKit

struct SkeletonLineLayerConfiguration {

    let type: SkeletonType
    let font: UIFont
    let numberOfLines: Int
    let lineCornerStyle: SkeletonCornerStyle
    let lineHeight: CGFloat
    let lineSpacing: SkeletonLineSpacing
    let lastLineFillPercent: Int
    let insets: UIEdgeInsets
    let alignment: NSTextAlignment
    let isRTL: Bool
    let shouldCenterVertically: Bool

}
