// Copyright © 2018 SkeletonView. All rights reserved.

import UIKit

/// Object that facilitates the creation of skeleton layers for multiline
/// elements, based on the builder pattern
class SkeletonLineLayerBuilder {

    var skeletonType: SkeletonType?
    var index: Int?
    var font: UIFont?
    var width: CGFloat?
    var height: CGFloat?
    var spacing: SkeletonLineSpacing?
    var insets: UIEdgeInsets = .zero
    var alignment: NSTextAlignment = .natural
    var isRTL: Bool = false

    @discardableResult
    func setSkeletonType(_ type: SkeletonType) -> Self {
        self.skeletonType = type
        return self
    }

    @discardableResult
    func setIndex(_ index: Int) -> Self {
        self.index = index
        return self
    }

    @discardableResult
    func setFont(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func setWidth(_ width: CGFloat) -> Self {
        self.width = width
        return self
    }

    @discardableResult
    func setHeight(_ height: CGFloat) -> Self {
        self.height = height
        return self
    }

    @discardableResult
    func setSpacing(_ spacing: SkeletonLineSpacing) -> Self {
        self.spacing = spacing
        return self
    }

    @discardableResult
    func setInsets(_ insets: UIEdgeInsets) -> Self {
        self.insets = insets
        return self
    }

    @discardableResult
    func setAlignment(_ alignment: NSTextAlignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    func setIsRTL(_ isRTL: Bool) -> Self {
        self.isRTL = isRTL
        return self
    }

    func build() -> CALayer? {
        guard let skeletonType,
              let index,
              let font,
              let width,
              let height,
              let spacing
            else { return nil }

        let layer = skeletonType.layer
        layer.anchorPoint = .zero
        layer.name = CALayer.Constants.skeletonSubLayersName
        layer.updateLayerFrame(for: index,
                               font: font,
                               numberOfLines: layer.skeletonSublayers.count,
                               size: CGSize(width: width, height: height),
                               lineSpacing: spacing,
                               insets: insets,
                               alignment: alignment,
                               isRTL: isRTL)

        layer.masksToBounds = true

        return layer
    }
    
}
