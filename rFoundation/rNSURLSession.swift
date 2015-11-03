//
//  rNSURLSession.swift
//  rFoundation
//
//  Created by Srdan Rasic on 25/10/15.
//  Copyright © 2015 Srdan Rasic. All rights reserved.
//

import rStreams
import rTasks
import Foundation

public extension NSURLSession {
  
  public func rDataTaskWithRequest(request: NSURLRequest) -> Task<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      task.resume()
      
      return BlockDisposable {
        task.cancel()
      }
    }
  }
  
  public func rDataTaskWithURL(url: NSURL) -> Task<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      task.resume()
      
      return BlockDisposable {
        task.cancel()
      }
    }
  }
  
  public func rUploadTaskWithRequest(request: NSURLRequest, fromFile fileURL: NSURL) -> Task<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let task = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromFile: fileURL) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      task.resume()
      
      return BlockDisposable {
        task.cancel()
      }
    }
  }
  
  public func rUploadTaskWithRequest(request: NSURLRequest, fromData bodyData: NSData?) -> Task<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let task = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromData: bodyData) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      task.resume()
      
      return BlockDisposable {
        task.cancel()
      }
    }
  }
  
  public func rDownloadTaskWithRequest(request: NSURLRequest) -> Task<(NSURL?, NSURLResponse?), NSError> {
    return create { sink in
      
      let task = NSURLSession.sharedSession().downloadTaskWithRequest(request) {
        url, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(url, response)
          sink.success()
        }
      }
      
      task.resume()
      
      return BlockDisposable {
        task.cancel()
      }
    }
  }
  
  public func rDownloadTaskWithURL(url: NSURL) -> Task<(NSURL?, NSURLResponse?), NSError> {
    return create { sink in
      
      let task = NSURLSession.sharedSession().downloadTaskWithURL(url) {
        url, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(url, response)
          sink.success()
        }
      }
      
      task.resume()
      
      return BlockDisposable {
        task.cancel()
      }
    }
  }
  
  public func rDownloadTaskWithResumeData(resumeData: NSData) -> Task<(NSURL?, NSURLResponse?), NSError> {
    return create { sink in
      
      let task = NSURLSession.sharedSession().downloadTaskWithResumeData(resumeData) {
        url, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(url, response)
          sink.success()
        }
      }
      
      task.resume()
      
      return BlockDisposable {
        task.cancel()
      }
    }
  }
}
