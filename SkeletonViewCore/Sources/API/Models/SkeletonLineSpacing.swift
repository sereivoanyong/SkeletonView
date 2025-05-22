//
//  SkeletonLineSpacing.swift
//  SkeletonView
//
//  Created by Sereivoan Yong on 5/20/25.
//

import UIKit

public enum SkeletonLineSpacing {

    case `default`

    case fixed(CGFloat)

    case custom((UIFont) -> CGFloat)

    public func resolved(for font: UIFont?) -> CGFloat {
        switch self {
        case .default:
            if let font {
                return font.lineHeight - font.capHeight
            } else {
                return -1
            }
        case .fixed(let value):
            return value
        case .custom(let provider):
            if let font {
                return provider(font)
            } else {
                return -1
            }
        }
    }

}
