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

public extension NSURLSession {
  
  public func rDataOperationWithRequest(request: NSURLRequest) -> Operation<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let Operation = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      Operation.resume()
      
      return BlockDisposable {
        Operation.cancel()
      }
    }
  }
  
  public func rDataOperationWithURL(url: NSURL) -> Operation<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let Operation = NSURLSession.sharedSession().dataTaskWithURL(url) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      Operation.resume()
      
      return BlockDisposable {
        Operation.cancel()
      }
    }
  }
  
  public func rUploadOperationWithRequest(request: NSURLRequest, fromFile fileURL: NSURL) -> Operation<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let Operation = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromFile: fileURL) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      Operation.resume()
      
      return BlockDisposable {
        Operation.cancel()
      }
    }
  }
  
  public func rUploadOperationWithRequest(request: NSURLRequest, fromData bodyData: NSData?) -> Operation<(NSData?, NSURLResponse?), NSError> {
    return create { sink in
      
      let Operation = NSURLSession.sharedSession().uploadTaskWithRequest(request, fromData: bodyData) {
        data, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(data, response)
          sink.success()
        }
      }
      
      Operation.resume()
      
      return BlockDisposable {
        Operation.cancel()
      }
    }
  }
  
  public func rDownloadOperationWithRequest(request: NSURLRequest) -> Operation<(NSURL?, NSURLResponse?), NSError> {
    return create { sink in
      
      let Operation = NSURLSession.sharedSession().downloadTaskWithRequest(request) {
        url, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(url, response)
          sink.success()
        }
      }
      
      Operation.resume()
      
      return BlockDisposable {
        Operation.cancel()
      }
    }
  }
  
  public func rDownloadOperationWithURL(url: NSURL) -> Operation<(NSURL?, NSURLResponse?), NSError> {
    return create { sink in
      
      let Operation = NSURLSession.sharedSession().downloadTaskWithURL(url) {
        url, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(url, response)
          sink.success()
        }
      }
      
      Operation.resume()
      
      return BlockDisposable {
        Operation.cancel()
      }
    }
  }
  
  public func rDownloadOperationWithResumeData(resumeData: NSData) -> Operation<(NSURL?, NSURLResponse?), NSError> {
    return create { sink in
      
      let Operation = NSURLSession.sharedSession().downloadTaskWithResumeData(resumeData) {
        url, response, error in
        
        if let error = error {
          sink.failure(error)
        } else {
          sink.next(url, response)
          sink.success()
        }
      }
      
      Operation.resume()
      
      return BlockDisposable {
        Operation.cancel()
      }
    }
  }
}
