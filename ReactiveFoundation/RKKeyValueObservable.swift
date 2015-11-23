//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Srdan Rasic (@srdanrasic)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import ReactiveKit
import Foundation

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
  public func observe(on context: ExecutionContext? = nil, observer: T -> ()) -> DisposableType {
    
    if self.observer == nil {

      if let context = context {
        self.observer = { e in
          context {
            observer(e)
          }
        }
      } else {
        self.observer = observer
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
