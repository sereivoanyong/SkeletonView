//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  SkeletonTextNode.swift
//
//  Created by Juanpe Catalán on 19/8/21.

import UIKit

protocol SkeletonTextNode: UIView {
    
    var _sk_font: UIFont { get }
    var _sk_numberOfLines: SkeletonNumberOfLines { get }
    var lineCornerStyle: SkeletonCornerStyle { get }
    var lineHeight: SkeletonLineHeight { get }
    var lineSpacing: SkeletonLineSpacing { get }
    var lastLineFillPercent: Int { get }
    var insets: NSDirectionalEdgeInsets { get }
    
    var estimatedNumberOfLines: Int { get }
    var estimatedLineHeight: CGFloat { get }
    
    var textAlignment: NSTextAlignment { get }
    
    var shouldCenterTextVertically: Bool { get }
    
}

enum SkeletonTextNodeAssociatedKeys {
    
    static var skeletonNumberOfLines: Void?
    static var lineCornerStyle: Void?
    static var lineHeight: Void?
    static var lineSpacing: Void?
    static var lastLineFillPercent: Void?
    static var insets: Void?
    static var backupHeightConstraints: Void?
    
}

extension SkeletonTextNode {

    var _sk_numberOfLines: SkeletonNumberOfLines {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.skeletonNumberOfLines) as? SkeletonNumberOfLines ?? SkeletonNumberOfLines.inherited }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.skeletonNumberOfLines) }
    }

    var lineCornerStyle: SkeletonCornerStyle {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lineCornerStyle) as? SkeletonCornerStyle ?? SkeletonAppearance.default.lineCornerStyle }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lineCornerStyle) }
    }

    var lineHeight: SkeletonLineHeight {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lineHeight) as? SkeletonLineHeight ?? SkeletonAppearance.default.lineHeight }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lineHeight) }
    }

    var lineSpacing: SkeletonLineSpacing {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lineSpacing) as? SkeletonLineSpacing ?? SkeletonAppearance.default.lineSpacing }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lineSpacing) }
    }

    var lastLineFillPercent: Int {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lastLineFillPercent) as? Int ?? SkeletonAppearance.default.lastLineFillPercent }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lastLineFillPercent) }
    }

    var insets: NSDirectionalEdgeInsets {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.insets) as? NSDirectionalEdgeInsets ?? .zero }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.insets) }
    }

}

extension UILabel: SkeletonTextNode {
    
    var _sk_font: UIFont {
        if let attributedText, attributedText.length > 0 {
            let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
            return attributes[.font] as? UIFont ?? font ?? .systemFont(ofSize: 15)
        } else {
            return font ?? .systemFont(ofSize: 15)
        }
    }
    
    var estimatedLineHeight: CGFloat {
        switch lineHeight {
        case .default:
            return _sk_font.capHeight
        case .fixed(let height):
            return height
        case .relativeToFont(let keyPath):
            return _sk_font[keyPath: keyPath]
        case .relativeToConstraints:
            guard let constraintsLineHeight = heightConstraints.first?.constant,
                  estimatedNumberOfLines != 0 else {
                return _sk_font.lineHeight
            }
            
            return constraintsLineHeight / CGFloat(estimatedNumberOfLines)
        }
    }
    
    var estimatedNumberOfLines: Int {
        switch _sk_numberOfLines {
        case .inherited:
            return numberOfLines
        case .custom(let lines):
            return lines >= 0 ? lines : 1
        }
    }
    
    var backupHeightConstraints: [NSLayoutConstraint] {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.backupHeightConstraints) as? [NSLayoutConstraint] ?? [] }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.backupHeightConstraints) }
    }
    
    var shouldCenterTextVertically: Bool {
        true
    }

}

extension UITextView: SkeletonTextNode {
    
    var _sk_font: UIFont {
        if let attributedText, attributedText.length > 0 {
            let attributes = attributedText.attributes(at: 0, effectiveRange: nil)
            return attributes[.font] as? UIFont ?? font ?? .systemFont(ofSize: 15)
        } else {
            return font ?? .systemFont(ofSize: 15)
        }
    }
    
    var estimatedLineHeight: CGFloat {
        switch lineHeight {
        case .default:
            return _sk_font.capHeight
        case .fixed(let height):
            return height
        case .relativeToFont(let keyPath):
            return _sk_font[keyPath: keyPath]
        case .relativeToConstraints:
            return _sk_font.lineHeight
        }
    }
    
    var estimatedNumberOfLines: Int {
        switch _sk_numberOfLines {
        case .inherited:
            return -1
        case .custom(let lines):
            return lines >= -1 ? lines : 1
        }
    }
    
    var shouldCenterTextVertically: Bool {
        false
    }
    
}
