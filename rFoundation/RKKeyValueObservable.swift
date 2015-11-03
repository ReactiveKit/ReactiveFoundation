//
//  RKKeyValueObservable.swift
//  rFoundation
//
//  Created by Srdan Rasic on 03/11/15.
//  Copyright © 2015 Srdan Rasic. All rights reserved.
//

import Foundation
import rKit

public class RKKeyValueObservable<T>: NSObject, StreamType {
  private var strongObject: NSObject? = nil
  private weak var object: NSObject? = nil
  private var context = 0
  private var keyPath: String
  private var options: NSKeyValueObservingOptions
  private var observer: (T -> ())? = nil
  private let transform: AnyObject? -> T?
  
  internal init(keyPath: String, ofObject object: NSObject, sendInitial: Bool, retainStrongly: Bool, transform: AnyObject? -> T?) {
    self.keyPath = keyPath
    self.options = sendInitial ? NSKeyValueObservingOptions.New.union(.Initial) : .New
    self.transform = transform
    super.init()
    
    self.object = object
    if retainStrongly {
      self.strongObject = object
    }
  }
  
  public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if context == &self.context {
      if let newValue = change?[NSKeyValueChangeNewKey] {
        if let newValue = transform(newValue) {
          observer?(newValue)
        } else {
          fatalError("Value [\(newValue)] not convertible to \(T.self) type!")
        }
      } else {
        // no new value - ignore
      }
    } else {
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    }
  }
  
  @warn_unused_result(message = "Key-Value observing is active as long as the disposable is alive and not disposed! Please store this disposable somewhere.")
  public func observe(on context: ExecutionContext, sink: T -> ()) -> DisposableType {
    
    if self.observer == nil {
      self.observer = { e in
        context {
          sink(e)
        }
      }
      self.object?.addObserver(self, forKeyPath: keyPath, options: options, context: &self.context)
    } else {
      fatalError("RKeyValueObserverStream does not support multiple observers! Please either use rValueForKeyPath() method to get another stream or `share` this stream as an `ActiveStream`.")
    }
    
    return DeinitDisposable(disposable: BlockDisposable {
      self.observer = nil
      self.object?.removeObserver(self, forKeyPath: self.keyPath)
      })
  }
}
