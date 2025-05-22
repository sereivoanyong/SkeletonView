//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  CALayer+Tint.swift
//
//  Created by Juanpe Catalán on 18/8/21.

import UIKit

extension CAGradientLayer {
    
    override func tint(withColors colors: [UIColor], traitCollection: UITraitCollection?) {
        skeletonSublayers.recursiveSearch(leafBlock: {
            if #available(iOS 13.0, tvOS 13, *), let traitCollection = traitCollection {
                self.colors = colors.map { $0.resolvedColor(with: traitCollection).cgColor }
            } else {
                self.colors = colors.map { $0.cgColor }
            }
        }) {
            $0.tint(withColors: colors, traitCollection: traitCollection)
        }
    }
    
}

extension CALayer {
    
    enum Constants {
        static let skeletonSubLayersName = "SkeletonSubLayersName"
    }
    
    var skeletonSublayers: [CALayer] {
        return sublayers?.filter { $0.name == Constants.skeletonSubLayersName } ?? [CALayer]()
    }
    
    @objc func tint(withColors colors: [UIColor], traitCollection: UITraitCollection?) {
        skeletonSublayers.recursiveSearch(leafBlock: {
            if #available(iOS 13.0, tvOS 13, *), let traitCollection = traitCollection {
                backgroundColor = colors.first?.resolvedColor(with: traitCollection).cgColor
            } else {
                backgroundColor = colors.first?.cgColor
            }
        }) {
            $0.tint(withColors: colors, traitCollection: traitCollection)
        }
    }
    
    func playAnimation(_ anim: SkeletonLayerAnimation, key: String, completion: (() -> Void)? = nil) {
        skeletonSublayers.recursiveSearch(leafBlock: {
            DispatchQueue.main.async { CATransaction.begin() }
            DispatchQueue.main.async { CATransaction.setCompletionBlock(completion) }
            add(anim(self), forKey: key)
            DispatchQueue.main.async { CATransaction.commit() }
        }) {
            $0.playAnimation(anim, key: key, completion: completion)
        }
    }
    
    func stopAnimation(forKey key: String) {
        skeletonSublayers.recursiveSearch(leafBlock: {
            removeAnimation(forKey: key)
        }) {
            $0.stopAnimation(forKey: key)
        }
    }
    
    func setOpacity(from: Int, to: Int, duration: TimeInterval, completion: (() -> Void)?) {
        DispatchQueue.main.async { CATransaction.begin() }
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        DispatchQueue.main.async { CATransaction.setCompletionBlock(completion) }
        add(animation, forKey: "setOpacityAnimation")
        DispatchQueue.main.async { CATransaction.commit() }
    }
    
    func insertSkeletonLayer(_ sublayer: SkeletonLayer, atIndex index: UInt32, transition: SkeletonTransitionStyle, completion: (() -> Void)? = nil) {
        insertSublayer(sublayer.contentLayer, at: index)
        switch transition {
        case .none:
            DispatchQueue.main.async { completion?() }
        case .crossDissolve(let duration):
            sublayer.contentLayer.setOpacity(from: 0, to: 1, duration: duration, completion: completion)
        }
    }
    
}

private extension CALayer {
    
    func alignLayerFrame(_ rect: CGRect, insets: UIEdgeInsets, alignment: NSTextAlignment, isRTL: Bool) -> CGRect {
        var newRect = rect
        let superlayerWidth = (superlayer?.bounds.width ?? 0)

        switch alignment {
        case .natural where isRTL,
             .right:
            newRect.origin.x = superlayerWidth - rect.width - insets.right
        case .center:
            newRect.origin.x = (superlayerWidth + insets.left - insets.right - rect.width) / 2
        case .natural, .left, .justified:
            break
        @unknown default:
            break
        }

        return newRect
    }
    
    func calculatedWidthForLine(at index: Int, totalLines: Int, lastLineFillPercent: CGFloat, insets: UIEdgeInsets) -> CGFloat {
        var width = bounds.width - insets.left - insets.right
        if index == totalLines - 1 {
            width = width * lastLineFillPercent
        }
        return width
    }
 
    func calculateNumberOfLines(for config: SkeletonLineLayerConfiguration) -> Int {
        let definedNumberOfLines = config.numberOfLines
        let requiredSpaceForEachLine = config.lineHeight + config.lineSpacing.resolved(for: config.font)
        let neededLines = round((bounds.height - config.insets.top - config.insets.bottom) / CGFloat(requiredSpaceForEachLine))
        guard neededLines.isNormal else {
            return 0
        }

        let calculatedNumberOfLines = Int(neededLines)
        guard calculatedNumberOfLines > 0 else {
            return 1
        }
        
        if definedNumberOfLines > 0, definedNumberOfLines <= calculatedNumberOfLines {
            return definedNumberOfLines
        }
        
        return calculatedNumberOfLines
    }
}

extension CALayer {
    
    func addLineLayers(for config: SkeletonLineLayerConfiguration) {
        let numberOfSublayers = config.numberOfLines > 0 ? config.numberOfLines : calculateNumberOfLines(for: config)
        let insets = config.insets
        var height = config.lineHeight
        
        if numberOfSublayers == 1 && SkeletonAppearance.default.renderSingleLineAsView {
            height = bounds.height
        }

        let layerBuilder = SkeletonLineLayerBuilder()
            .setSkeletonType(config.type)
            .setFont(config.font)
            .setHeight(height)
            .setSpacing(config.lineSpacing)
            .setInsets(insets)
            .setAlignment(config.alignment)
            .setIsRTL(config.isRTL)
    
        (0..<numberOfSublayers).forEach { index in
            let width = calculatedWidthForLine(at: index, totalLines: numberOfSublayers, lastLineFillPercent: config.lastLineFillPercent, insets: insets)
            if let layer = layerBuilder
                .setIndex(index)
                .setWidth(width)
                .build() {
                addSublayer(layer)
            }
        }
    }

    func updateLineLayers(for config: SkeletonLineLayerConfiguration) {
        let currentSkeletonSublayers = skeletonSublayers
        let numberOfSublayers = currentSkeletonSublayers.count
        let insets = config.insets
        var height = config.lineHeight
        
        if numberOfSublayers == 1 && SkeletonAppearance.default.renderSingleLineAsView {
            height = bounds.height
        }
        
        for (index, layer) in currentSkeletonSublayers.enumerated() {
            let width = calculatedWidthForLine(at: index, totalLines: numberOfSublayers, lastLineFillPercent: config.lastLineFillPercent, insets: insets)
            layer.updateLayerFrame(for: index,
                                   font: config.font,
                                   numberOfLines: numberOfSublayers,
                                   size: CGSize(width: width, height: height),
                                   lineSpacing: config.lineSpacing,
                                   insets: insets,
                                   alignment: config.alignment,
                                   isRTL: config.isRTL)
            layer.cornerRadius = config.lineCornerStyle.resolved(for: layer.bounds)
        }
        
        guard config.shouldCenterVertically,
              let maxY = currentSkeletonSublayers.last?.frame.maxY else {
            return
        }
        let verticallyCenterAlignedFrames = currentSkeletonSublayers.map { layer -> CGRect in
            let moveDownBy = (bounds.height - (maxY + insets.top + insets.bottom)) / 2
            return layer.frame.offsetBy(dx: 0, dy: moveDownBy)
        }
        
        for (index, layer) in currentSkeletonSublayers.enumerated() {
            layer.frame = verticallyCenterAlignedFrames[index]
        }
    }

    func updateLayerFrame(for index: Int, font: UIFont, numberOfLines: Int, size: CGSize, lineSpacing: SkeletonLineSpacing, insets: UIEdgeInsets, alignment: NSTextAlignment, isRTL: Bool) {
        let spaceRequiredForEachLine = size.height + lineSpacing.resolved(for: font)
        let newFrame = CGRect(x: insets.left,
                              y: CGFloat(index) * spaceRequiredForEachLine + insets.top,
                              width: size.width,
                              height: size.height)

        if index == numberOfLines - 1 {
            frame = alignLayerFrame(newFrame, insets: insets, alignment: alignment, isRTL: isRTL)
        } else {
            frame = newFrame
        }
    }
    
}
