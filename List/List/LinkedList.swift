//
//  LinkedList.swift
//  List
//
//  Created by 胡聪 on 2020/3/19.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation


public class LinkedList<Element>: List {
    
    private var head: Node<Element>? = Node<Element>(element: nil)
    
    private var _size = 0
    
    public var size: Int {
        _size
    }
    
    public subscript(index: Int) -> Element {
        get {
            return _node(at: index).element!
        }
        set {
            insert(newValue, at: index)
        }
    }
    
    
    public func append(_ element: Element) {
        
        insert(element, at: size)
    }
    
    public func insert(_ element: Element, at index: Int) {
        _checkBounds(index)

        let node = _node(at: index)
        let newNode = Node(element: element)
        newNode.next = node.next
        node.next = newNode
        
        _size += 1
    }
    
    private func _node(at index: Int) -> Node<Element> {
        _checkBounds(index)
        
        var tmp = head
        for _ in 0..<index {
            tmp = tmp?.next
        }

        return tmp!
    }
    
    @discardableResult
    public func remove(at index: Int) -> Element {
        let node = _node(at: index)
        
        let next = node.next
        node.next = node.next?.next
        _size -= 1
        
        return next!.element!
    }
    
    public func clear() {
        head?.next = nil
        _size = 0
    }
    
    public func reverse() {
        head?.next = _reverse(node: head?.next)
    }
    
    public var hasCycle: Bool {
        
        if head?.next == nil || head?.next?.next == nil {
            return false
        }
        
        var fast = head?.next?.next
        var slow = head?.next
        
        while fast != nil && slow != nil {
            if fast == slow {
                return true
            }
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        return false
    }
    
    private func _checkBounds(_ index: Int) {
        if index < 0 || index > _size {
            fatalError("索引越界: \(index) out of bounds[0, \(_size))")
        }
    }

    @discardableResult
    private func _reverse(node: Node<Element>?) -> Node<Element>? {
        if node == nil || node?.next == nil {
            return node
        }
        
        let result = _reverse(node: node?.next)
        
        node?.next?.next = node
        node?.next = nil
        
        return result
    }
    
    private class Node<Element>: Equatable {

        var element: Element?
        var next: Node<Element>?
        
        init(element: Element?) {
            self.element = element
        }
        
        static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
            Unmanaged.passUnretained(lhs).toOpaque() == Unmanaged.passUnretained(rhs).toOpaque()
        }
        
        deinit {
            guard let e = element else {
                print("head(nil)释放了")
                return
            }
            print("node(\(e))释放了")
        }
    }
}



extension LinkedList: CustomStringConvertible {
    public var description: String {
        
        var tmp = head
        var string = "size = \(size), head -> "
        while tmp?.next != nil {
            tmp = tmp?.next
            string += "\(tmp!.element!) -> "
        }
        
        string.removeLast(3)
        
        return string
    }
}
