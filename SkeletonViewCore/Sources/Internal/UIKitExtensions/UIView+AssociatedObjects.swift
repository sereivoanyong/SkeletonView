//
//  Copyright SkeletonView. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  UIView+AssociatedObjects.swift
//
//  Created by Juanpe Catalán on 18/8/21.

import UIKit

// codebeat:disable[TOO_MANY_IVARS]
enum ViewAssociatedKeys {
    
    static var skeletonable: Void?
    static var hiddenWhenSkeletonIsActive: Void?
    static var status: Void?
    static var skeletonLayer: Void?
    static var flowDelegate: Void?
    static var isSkeletonAnimated: Void?
    static var viewState: Void?
    static var labelViewState: Void?
    static var imageViewState: Void?
    static var buttonViewState: Void?
    static var headerFooterViewState: Void?
    static var currentSkeletonConfig: Void?
    static var skeletonCornerStyle: Void?
    static var disabledWhenSkeletonIsActive: Void?
    static var delayedShowSkeletonWorkItem: Void?
    
}
// codebeat:enable[TOO_MANY_IVARS]

extension UIView {
    
    enum SkeletonStatus {
        case on
        case off
    }

    var _flowDelegate: SkeletonFlowDelegate? {
        get { return ao_object(forKey: &ViewAssociatedKeys.flowDelegate) as? SkeletonFlowDelegate }
        set { ao_setObject(newValue, forKey: &ViewAssociatedKeys.flowDelegate) }
    }

    var _skeletonLayer: SkeletonLayer? {
        get { return ao_value(forKey: &ViewAssociatedKeys.skeletonLayer) as? SkeletonLayer }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.skeletonLayer) }
    }

    var _currentSkeletonConfig: SkeletonConfig? {
        get { return ao_value(forKey: &ViewAssociatedKeys.currentSkeletonConfig) as? SkeletonConfig }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.currentSkeletonConfig) }
    }

    var _status: SkeletonStatus {
        get { return ao_value(forKey: &ViewAssociatedKeys.status) as? SkeletonStatus ?? .off }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.status) }
    }

    var _isSkeletonAnimated: Bool {
        get { return ao_value(forKey: &ViewAssociatedKeys.isSkeletonAnimated) as? Bool ?? false }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.isSkeletonAnimated) }
    }
    
    var _delayedShowSkeletonWorkItem: DispatchWorkItem? {
        get { return ao_object(forKey: &ViewAssociatedKeys.delayedShowSkeletonWorkItem) as? DispatchWorkItem }
        set { ao_setObject(newValue, forKey: &ViewAssociatedKeys.delayedShowSkeletonWorkItem) }
    }
    
    var _skeletonable: Bool {
        get { return ao_value(forKey: &ViewAssociatedKeys.skeletonable) as? Bool ?? false }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.skeletonable) }
    }
    
    var _hiddenWhenSkeletonIsActive: Bool {
        get { return ao_value(forKey: &ViewAssociatedKeys.hiddenWhenSkeletonIsActive) as? Bool ?? false }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.hiddenWhenSkeletonIsActive) }
    }
    
    var _disabledWhenSkeletonIsActive: Bool {
        get { return ao_value(forKey: &ViewAssociatedKeys.disabledWhenSkeletonIsActive) as? Bool ?? true }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.disabledWhenSkeletonIsActive) }
    }

    var _skeletonableCornerStyle: SkeletonCornerStyle {
        get { return ao_value(forKey: &ViewAssociatedKeys.skeletonCornerStyle) as? SkeletonCornerStyle ?? SkeletonAppearance.default.cornerStyle }
        set { ao_setValue(newValue, forKey: &ViewAssociatedKeys.skeletonCornerStyle) }
    }
}
