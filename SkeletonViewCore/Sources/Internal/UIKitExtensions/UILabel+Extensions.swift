//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  UILabel+Extensions.swift
//
//  Created by Juanpe Catalán on 19/8/21.

import UIKit

extension UILabel {
    
    var desiredHeightBasedOnNumberOfLines: CGFloat {
        let estimatedNumberOfLines = _sk_estimatedNumberOfLines
        let spaceNeededForEachLine = _sk_estimatedLineHeight * CGFloat(estimatedNumberOfLines)
        let spaceNeededForSpaces = _sk_lineSpacing.resolved(for: _sk_font) * CGFloat(estimatedNumberOfLines - 1)
        let insets = _sk_insets
        let padding = insets.top + insets.bottom

        return spaceNeededForEachLine + spaceNeededForSpaces + padding
    }
    
    func updateHeightConstraintsIfNeeded() {
        let estimatedNumberOfLines = _sk_estimatedNumberOfLines
        guard estimatedNumberOfLines > 1 || estimatedNumberOfLines == 0 else { return }
        
        // Workaround to simulate content when the label is contained in a `UIStackView`.
        if isSuperviewAStackView, bounds.height == 0, (text?.isEmpty ?? true) {
            // This is a placeholder text to simulate content because it's contained in a stack view in order to prevent that the content size will be zero.
            text = " "
        }
        
        let desiredHeight = desiredHeightBasedOnNumberOfLines
        if desiredHeight > definedMaxHeight {
            backupHeightConstraints = heightConstraints
            NSLayoutConstraint.deactivate(heightConstraints)
            setHeight(equalToConstant: desiredHeight)
        }
    }
    
    func restoreBackupHeightConstraintsIfNeeded() {
        guard !backupHeightConstraints.isEmpty else { return }
        NSLayoutConstraint.activate(backupHeightConstraints)
        backupHeightConstraints.removeAll()
    }
    
}
