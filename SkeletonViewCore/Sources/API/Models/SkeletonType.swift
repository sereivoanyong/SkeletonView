//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  SkeletonType.swift
//
//  Created by Juanpe Catalán on 19/8/21.

import UIKit

#if DEBUG

final private class Layer: CALayer {
    
    private static var referenceCount: Int = 0
    
    override init(layer: Any) {
        super.init(layer: layer)
        Self.referenceCount += 1
        skeletonLog("Layer created: \(Self.referenceCount) in total")
    }
    
    override init() {
        super.init()
        Self.referenceCount += 1
        skeletonLog("Layer created. \(Self.referenceCount) in total")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Self.referenceCount += 1
        skeletonLog("Layer created. \(Self.referenceCount) in total")
    }
    
    deinit {
        Self.referenceCount -= 1
        skeletonLog("Layer destroyed. \(Self.referenceCount) left")
    }
}

final private class GradientLayer: CAGradientLayer {
    
    private static var referenceCount: Int = 0
    
    override init(layer: Any) {
        super.init(layer: layer)
        Self.referenceCount += 1
        skeletonLog("Layer created: \(Self.referenceCount) in total")
    }
    
    override init() {
        super.init()
        Self.referenceCount += 1
        skeletonLog("Layer created. \(Self.referenceCount) in total")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Self.referenceCount += 1
        skeletonLog("Layer created. \(Self.referenceCount) in total")
    }
    
    deinit {
        Self.referenceCount -= 1
        skeletonLog("Layer destroyed. \(Self.referenceCount) left")
    }
}
#else
private typealias Layer = CALayer
private typealias GradientLayer = CAGradientLayer
#endif

public enum SkeletonType {
    
    case solid
    case gradient
    
    var layer: CALayer {
        switch self {
        case .solid:
            return Layer()
        case .gradient:
            return GradientLayer()
        }
    }
    
    func defaultLayerAnimation(isRTL: Bool) -> SkeletonLayerAnimation {
        switch self {
        case .solid:
            return { $0.pulse }
        case .gradient:
            return { SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: isRTL ? .rightLeft : .leftRight) }()
        }
    }
    
}
