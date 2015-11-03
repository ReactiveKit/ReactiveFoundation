//
//  rFoundationTests.swift
//  rFoundationTests
//
//  Created by Srdan Rasic on 25/10/15.
//  Copyright © 2015 Srdan Rasic. All rights reserved.
//

import XCTest
@testable import rFoundation
import rStreams
import Foundation

class rFoundationTests: XCTestCase {
  
  dynamic var title: String = "Haha"
  var d: DisposableType! = nil
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    var u: User? = User()
    
    u?.rName.observe(on: ImmediateExecutionContext) { (n: String?) in
      print(n)
    }
    
    u = nil
    u?.name = "Spock"
    u?.name = nil
    
    //d.dispose()
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }
}

class User: NSObject {
  dynamic var name: String? = "Jim"
  
  var rName: RKKeyValueObservable<String?> {
    return rValueForKeyPath("name")
  }
  
  deinit {
    print("User deinit")
  }
}
