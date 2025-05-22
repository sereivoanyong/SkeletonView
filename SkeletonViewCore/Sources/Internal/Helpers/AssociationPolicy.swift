//  Copyright © 2017 SkeletonView. All rights reserved.

import Foundation
import ObjectiveC.runtime

@usableFromInline
final class Reference {

  @usableFromInline
  let value: Any

  init(_ value: Any) {
    self.value = value
  }
}

extension NSObjectProtocol {

    /// wrapper around `objc_getAssociatedObject`
    func ao_object(forKey key: UnsafeRawPointer) -> AnyObject? {
        return objc_getAssociatedObject(self, key) as? AnyObject
    }

    /// wrapper around `objc_setAssociatedObject`
    func ao_setObject(_ object: AnyObject?, forKey key: UnsafeRawPointer, policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        objc_setAssociatedObject(self, key, object, policy)
    }

    /// wrapper around `objc_getAssociatedObject`
    func ao_value(forKey key: UnsafeRawPointer) -> Any? {
        return (objc_getAssociatedObject(self, key) as? Reference)?.value
    }

    /// wrapper around `objc_setAssociatedObject`
    func ao_setValue(_ value: Any?, forKey key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, value.map(Reference.init), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /// wrapper around 'objc_removeAssociatedObjects'
    func ao_removeAll() {
        objc_removeAssociatedObjects(self)
    }
}
