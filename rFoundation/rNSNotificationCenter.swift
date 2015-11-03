//
//  rNSNotificationCenter.swift
//  rFoundation
//
//  Created by Srdan Rasic on 25/10/15.
//  Copyright © 2015 Srdan Rasic. All rights reserved.
//

import rStreams
import Foundation

extension NSNotificationCenter {
  
  public func rNotification(name: String, object: AnyObject?) -> Stream<NSNotification> {
    return create { sink in
      let subscription = NSNotificationCenter.defaultCenter().addObserverForName(name, object: object, queue: nil, usingBlock: { notification in
        sink(notification)
      })
      return BlockDisposable {
        NSNotificationCenter.defaultCenter().removeObserver(subscription)
      }
    }
  }
}
