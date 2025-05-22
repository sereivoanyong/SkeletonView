//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  SkeletonAppearance.swift
//

import UIKit

// codebeat:disable[TOO_MANY_IVARS]
final public class SkeletonAppearance {

    public static let `default` = SkeletonAppearance()

    public var tintColor: UIColor = .skeletonDefault

    public var gradient: SkeletonGradient = SkeletonGradient(baseColor: .skeletonDefault)

    public var cornerStyle: SkeletonCornerStyle = .fixed(0)

    public var lineCornerStyle: SkeletonCornerStyle = .fixed(0)

    public var lineHeight: SkeletonLineHeight = .default

    public var lineSpacing: SkeletonLineSpacing = .default

    public var lastLineFillPercent: Int = 70

    public var renderSingleLineAsView: Bool = false

}
// codebeat:enable[TOO_MANY_IVARS]
