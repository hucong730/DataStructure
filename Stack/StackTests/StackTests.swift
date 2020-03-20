//
//  StackTests.swift
//  StackTests
//
//  Created by 胡聪 on 2020/3/20.
//  Copyright © 2020 胡聪. All rights reserved.
//

import XCTest
@testable import Stack

class StackTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test() {
        let stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
        
        print(stack.top as Any)
        
        print(stack.pop() as Any)
        
        print(stack)
    }

}
