//
//  SkeletonLayer.swift
//  SkeletonView-iOS
//
//  Created by Juanpe Catalán on 02/11/2017.
//  Copyright © 2017 SkeletonView. All rights reserved.
//

import UIKit

struct SkeletonLayer {
    
    private var maskLayer: CALayer
    private weak var holder: UIView?
    
    var type: SkeletonType {
        return maskLayer is CAGradientLayer ? .gradient : .solid
    }
    
    var contentLayer: CALayer {
        return maskLayer
    }
    
    init(type: SkeletonType, colors: [UIColor], skeletonHolder holder: UIView) {
        self.holder = holder
        self.maskLayer = type.layer
        self.maskLayer.anchorPoint = .zero
        self.maskLayer.bounds = holder.definedMaxBounds
        self.maskLayer.cornerRadius = holder.skeletonCornerStyle.resolved(for: self.maskLayer.bounds)
        addTextLinesIfNeeded()
        self.maskLayer.tint(withColors: colors, traitCollection: holder.traitCollection)
    }
    
    func update(usingColors colors: [UIColor]) {
        layoutIfNeeded()
        maskLayer.tint(withColors: colors, traitCollection: holder?.traitCollection)
    }

    func layoutIfNeeded() {
        if let holder {
            maskLayer.bounds = holder.definedMaxBounds
            maskLayer.cornerRadius = holder.skeletonCornerStyle.resolved(for: maskLayer.bounds)
        }
        updateLinesIfNeeded()
    }
    
    func removeLayer(transition: SkeletonTransitionStyle, completion: (() -> Void)? = nil) {
        switch transition {
        case .none:
            maskLayer.removeFromSuperlayer()
            completion?()
        case .crossDissolve(let duration):
            maskLayer.setOpacity(from: 1, to: 0, duration: duration) {
                self.maskLayer.removeFromSuperlayer()
                completion?()
            }
        }
    }

    /// If there is more than one line, or custom preferences have been set for a single line, draw custom layers
    func addTextLinesIfNeeded() {
        guard let textView = holderAsTextView else { return }
        let isRTL = textView.isRTL
        let config = SkeletonLineLayerConfiguration(type: type,
                                                    font: textView._sk_font,
                                                    numberOfLines: textView.estimatedNumberOfLines,
                                                    lineCornerStyle: textView.lineCornerStyle,
                                                    lineHeight: textView.estimatedLineHeight,
                                                    lineSpacing: textView.lineSpacing,
                                                    lastLineFillPercent: textView.lastLineFillPercent,
                                                    insets: textView.insets.resolved(isRTL: isRTL),
                                                    alignment: textView.textAlignment,
                                                    isRTL: isRTL,
                                                    shouldCenterVertically: textView.shouldCenterTextVertically)

        maskLayer.addLineLayers(for: config)
    }
    
    func updateLinesIfNeeded() {
        guard let textView = holderAsTextView else { return }
        let isRTL = textView.isRTL
        let config = SkeletonLineLayerConfiguration(type: type,
                                                    font: textView._sk_font,
                                                    numberOfLines: textView.estimatedNumberOfLines,
                                                    lineCornerStyle: textView.lineCornerStyle,
                                                    lineHeight: textView.estimatedLineHeight,
                                                    lineSpacing: textView.lineSpacing,
                                                    lastLineFillPercent: textView.lastLineFillPercent,
                                                    insets: textView.insets.resolved(isRTL: isRTL),
                                                    alignment: textView.textAlignment,
                                                    isRTL: isRTL,
                                                    shouldCenterVertically: textView.shouldCenterTextVertically)

        maskLayer.updateLineLayers(for: config)
    }
    
    var holderAsTextView: SkeletonTextNode? {
        guard let textView = holder as? SkeletonTextNode,
            (textView.estimatedNumberOfLines == -1 || textView.estimatedNumberOfLines == 0 || textView.estimatedNumberOfLines > 1 || textView.estimatedNumberOfLines == 1 && !SkeletonAppearance.default.renderSingleLineAsView) else {
                return nil
        }
        return textView
    }
    
}

extension SkeletonLayer {
    
    func start(_ anim: SkeletonLayerAnimation? = nil, completion: (() -> Void)? = nil) {
        let animation = anim ?? type.defaultLayerAnimation(isRTL: holder?.isRTL ?? false)
        contentLayer.playAnimation(animation, key: "skeletonAnimation", completion: completion)
    }

    func stopAnimation() {
        contentLayer.stopAnimation(forKey: "skeletonAnimation")
    }
    
}
