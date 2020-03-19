//
//  ListTests.swift
//  ListTests
//
//  Created by 胡聪 on 2020/3/19.
//  Copyright © 2020 胡聪. All rights reserved.
//

import XCTest
@testable import List

class ListTests: XCTestCase {

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
        let list = LinkedList<Int>()
        
        list.append(1)
        list.append(2)
        list.append(3)
        list.append(4)
        
        print(list)
        
        list[2] = 7
        
        print(list)
        
        list[5] = 9
        
        print(list)
        
        list.remove(at: 0)
        
        print(list)
        
        list.reverse()
        
        
        print("链表是否为空：\(list.isEmpty)")
        print(list)
        
        
        print("链表是否有环：\(list.hasCycle)")
        
        list.clear()
        
        print(list)
        print("链表是否为空：\(list.isEmpty)")
    }

}
