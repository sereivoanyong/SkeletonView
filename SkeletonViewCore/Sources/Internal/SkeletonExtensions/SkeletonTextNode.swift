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
    
    var textAlignment: NSTextAlignment { get }

    var _sk_font: UIFont { get }
    var _sk_numberOfLines: Int? { get }
    var _sk_lineCornerStyle: SkeletonCornerStyle { get }
    var _sk_lineHeight: SkeletonLineHeight { get }
    var _sk_lineSpacing: SkeletonLineSpacing { get }
    var _sk_lastLineFillPercent: CGFloat { get }
    var _sk_insets: NSDirectionalEdgeInsets { get }

    var _sk_estimatedNumberOfLines: Int { get }
    var _sk_estimatedLineHeight: CGFloat { get }

    var _sk_shouldCenterTextVertically: Bool { get }

}

enum SkeletonTextNodeAssociatedKeys {
    
    static var numberOfLines: Void?
    static var lineCornerStyle: Void?
    static var lineHeight: Void?
    static var lineSpacing: Void?
    static var lastLineFillPercent: Void?
    static var insets: Void?
    static var backupHeightConstraints: Void?
    
}

extension SkeletonTextNode {

    var _sk_numberOfLines: Int? {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.numberOfLines) as? Int }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.numberOfLines) }
    }

    var _sk_lineCornerStyle: SkeletonCornerStyle {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lineCornerStyle) as? SkeletonCornerStyle ?? SkeletonAppearance.default.lineCornerStyle }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lineCornerStyle) }
    }

    var _sk_lineHeight: SkeletonLineHeight {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lineHeight) as? SkeletonLineHeight ?? SkeletonAppearance.default.lineHeight }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lineHeight) }
    }

    var _sk_lineSpacing: SkeletonLineSpacing {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lineSpacing) as? SkeletonLineSpacing ?? SkeletonAppearance.default.lineSpacing }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lineSpacing) }
    }

    var _sk_lastLineFillPercent: CGFloat {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.lastLineFillPercent) as? CGFloat ?? SkeletonAppearance.default.lastLineFillPercent }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.lastLineFillPercent) }
    }

    var _sk_insets: NSDirectionalEdgeInsets {
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
    
    var backupHeightConstraints: [NSLayoutConstraint] {
        get { return ao_value(forKey: &SkeletonTextNodeAssociatedKeys.backupHeightConstraints) as? [NSLayoutConstraint] ?? [] }
        set { ao_setValue(newValue, forKey: &SkeletonTextNodeAssociatedKeys.backupHeightConstraints) }
    }
    
    var _sk_shouldCenterTextVertically: Bool {
        true
    }
    
    var _sk_estimatedNumberOfLines: Int {
        if let _sk_numberOfLines {
            return _sk_numberOfLines >= 0 ? _sk_numberOfLines : 1
        } else {
            return numberOfLines
        }
    }
    
    var _sk_estimatedLineHeight: CGFloat {
        switch _sk_lineHeight {
        case .default:
            return _sk_font.capHeight
        case .fixed(let height):
            return height
        case .relativeToFont(let keyPath):
            return _sk_font[keyPath: keyPath]
        case .relativeToConstraints:
            let estimatedNumberOfLines = _sk_estimatedNumberOfLines
            guard let constraintsLineHeight = heightConstraints.first?.constant,
                  estimatedNumberOfLines != 0 else {
                return _sk_font.lineHeight
            }
            
            return constraintsLineHeight / CGFloat(estimatedNumberOfLines)
        }
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
    
    var _sk_shouldCenterTextVertically: Bool {
        false
    }
    
    var _sk_estimatedNumberOfLines: Int {
        if let _sk_numberOfLines {
            return _sk_numberOfLines >= -1 ? _sk_numberOfLines : 1
        } else {
            return -1
        }
    }
    
    var _sk_estimatedLineHeight: CGFloat {
        switch _sk_lineHeight {
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
    
}
