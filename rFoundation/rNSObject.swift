//
//  rNSObject.swift
//  rFoundation
//
//  Created by Srdan Rasic on 25/10/15.
//  Copyright © 2015 Srdan Rasic. All rights reserved.
//

import Foundation
import rStreams

public extension NSObject {
  
  private struct AssociatedKeys {
    static var DisposeBagKey = "r_DisposeBagKey"
    static var AssociatedObservablesKey = "r_AssociatedObservablesKey"
  }
  
  public var rBag: DisposeBag {
    if let disposeBag: AnyObject = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBagKey) {
      return disposeBag as! DisposeBag
    } else {
      let disposeBag = DisposeBag()
      objc_setAssociatedObject(self, &AssociatedKeys.DisposeBagKey, disposeBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return disposeBag
    }
  }
  
  @warn_unused_result
  public func rValueForKeyPath<T>(keyPath: String, sendInitial: Bool = true, retainStrongly: Bool = true) -> RKKeyValueObservable<T> {
    return RKKeyValueObservable(keyPath: keyPath, ofObject: self, sendInitial: sendInitial, retainStrongly: retainStrongly) { (object: AnyObject?) -> T? in
      return object as? T
    }
  }
  
  @warn_unused_result
  public func rValueForKeyPath<T: OptionalType>(keyPath: String, sendInitial: Bool = true, retainStrongly: Bool = true) -> RKKeyValueObservable<T> {
    return RKKeyValueObservable(keyPath: keyPath, ofObject: self, sendInitial: sendInitial, retainStrongly: retainStrongly) { (object: AnyObject?) -> T? in
      if object == nil {
        return T()
      } else {
        if let object = object as? T.Wrapped {
          return T(object)
        } else {
          return T()
        }
      }
    }
  }
}

public extension NSObject {
  
  internal var r_associatedObservables: [String:AnyObject] {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.AssociatedObservablesKey) as? [String:AnyObject] ?? [:]
    }
    set(observable) {
      objc_setAssociatedObject(self, &AssociatedKeys.AssociatedObservablesKey, observable, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  public func rAssociatedObservableForValueForKey<T>(key: String, initial: T? = nil, set: (T -> ())? = nil) -> Observable<T> {
    if let observable: AnyObject = r_associatedObservables[key] {
      return observable as! Observable<T>
    } else {
      let observable = Observable<T>(initial ?? self.valueForKey(key) as! T)
      r_associatedObservables[key] = observable
      
      observable
        .observe { [weak self] (value: T) in
          if let set = set {
            set(value)
          } else {
            if let value = value as? AnyObject {
              self?.setValue(value, forKey: key)
            } else {
              self?.setValue(nil, forKey: key)
            }
          }
      }
      
      return observable
    }
  }
  
  public func rAssociatedObservableForValueForKey<T: OptionalType>(key: String, initial: T? = nil, set: (T -> ())? = nil) -> Observable<T> {
    if let observable: AnyObject = r_associatedObservables[key] {
      return observable as! Observable<T>
    } else {
      let observable: Observable<T>
      if let initial = initial {
        observable = Observable(initial)
      } else if let value = self.valueForKey(key) as? T.Wrapped {
        observable = Observable(T(value))
      } else {
        observable = Observable(T())
      }
      
      r_associatedObservables[key] = observable
      
      observable
        .observe { [weak self] (value: T) in
          if let set = set {
            set(value)
          } else {
            self?.setValue(value._unbox as! AnyObject?, forKey: key)
          }
      }
      
      return observable
    }
  }
}
