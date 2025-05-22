//
//  SkeletonCornerStyle.swift
//  SkeletonView
//
//  Created by Sereivoan Yong on 5/22/25.
//

import UIKit

public enum SkeletonCornerStyle {

    case fixed(CGFloat)

    case capsule

    public func resolved(for rect: CGRect?) -> CGFloat {
        switch self {
        case .fixed(let radius):
            return radius
        case .capsule:
            if let rect {
                return min(rect.width, rect.height) / 2
            } else {
                return -1
            }
        }
    }
}
