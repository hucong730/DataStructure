//
//  TreeTests.swift
//  TreeTests
//
//  Created by 胡聪 on 2020/3/20.
//  Copyright © 2020 胡聪. All rights reserved.
//

import XCTest
@testable import Tree

class TreeTests: XCTestCase {

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
        let tree = BinaryTree<Int>()
        
        let node7 = Node(7)
        let node4 = Node(4)
        let node9 = Node(9)
        let node2 = Node(2)
        let node5 = Node(5)
        let node8 = Node(8)
        let node11 = Node(11)
        let node1 = Node(1)
        let node3 = Node(3)
        let node10 = Node(10)
        let node12 = Node(12)
        
        tree.add(node: node7)
        tree.add(node: node4, parent: node7)
        tree.add(node: node9, parent: node7)
        tree.add(node: node2, parent: node4)
        tree.add(node: node5, parent: node4)
        tree.add(node: node8, parent: node9)
        tree.add(node: node11, parent: node9)
        tree.add(node: node1, parent: node2)
        tree.add(node: node3, parent: node2)
        tree.add(node: node10, parent: node11)
        tree.add(node: node12, parent: node11)
        
        
        print(tree)
    }

    func testBSTree() {
        let tree = BSTree<Int>()
        
        tree.add(10)
        tree.add(7)
        tree.add(12)
        tree.add(5)
        tree.add(4)
        tree.add(6)
//        tree.add(8)
        
        print(tree)
        
        print(tree.predecessor(tree.root))
        print(tree.successor(tree.root?.right))
        
        tree.remove(5)
        
        print(tree)
    }
    
}
