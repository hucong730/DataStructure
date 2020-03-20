//
//  QueueTests.swift
//  QueueTests
//
//  Created by 胡聪 on 2020/3/20.
//  Copyright © 2020 胡聪. All rights reserved.
//

import XCTest
@testable import Queue

class QueueTests: XCTestCase {

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
        let queue = Queue<Int>()
        for i in 1...50 {
            DispatchQueue.global().async {
                queue.enQueue(i)
            }
        }

        DispatchQueue.global().async(flags: .barrier) {
            print(queue)
        }
    }
    
    func test2() {
        let queue = Queue<Int>()
        
        queue.enQueue(1)
        queue.enQueue(2)
        queue.enQueue(3)
        queue.enQueue(4)
        
        print(queue.peek as Any)

        print(queue.deQueue() as Any)
        
        print(queue)
    }

}
