//
//  DoubleLinkedList.swift
//  List
//
//  Created by 胡聪 on 2020/3/19.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation


class DoubleLinkedList<Element>: List {
    
    private var head: Node<Element>? = Node<Element>(element: nil)
    private var tail: Node<Element>? = Node<Element>(element: nil)
    
    private var _size = 0
    
    init() {
        head?.next = tail
        tail?.prev = head
    }
    
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

        /*
        let half = _size >> 1
        var tmp = head
        var i = 0
        let node = Node(element: element)
        if index > half { //从尾部开始遍历
            tmp = tail
            i = _size - 1
            while tmp?.prev != nil && tmp?.prev != head && i >= index {
                tmp = tmp?.prev
                i -= 1
            }
            
            let prev = tmp?.prev
            node.next = tmp
            node.prev = prev
            prev?.next = node
            tmp?.prev = node
            
        } else { //从头部开始遍历
            while tmp?.next != nil && tmp?.next != tail && i <= index {
                tmp = tmp?.next
                i += 1
            }
            
            let next = tmp?.next
            node.next = next
            node.prev = tmp
            tmp?.next = node
            next?.prev = node
        }*/
        
        let node = _node(at: index)
        let newNode = Node(element: element)
        newNode.prev = node
        newNode.next = node.next
        node.next?.prev = newNode
        node.next = newNode
//        node.prev?.next = newNode
//        newNode.prev = node
//        newNode.next = node
//        node.prev = newNode
        
        
        _size += 1
    }
    
    private func _node(at index: Int) -> Node<Element> {
        _checkBounds(index)
        
        let half = _size >> 1
        var tmp = head
        var i = 0
        if index > half { //从尾部开始遍历
            tmp = tail
//            i = _size - 1
            for _ in stride(from: _size, to: index - 1, by: -1) {
                tmp = tmp?.prev
            }
//            while tmp?.prev != nil && tmp?.prev != head && i >= index {
//                tmp = tmp?.prev
//                i -= 1
//            }
//            tmp = tmp?.prev
        } else { //从头部开始遍历
            for _ in 0..<index {
                tmp = tmp?.next
            }
//            while tmp?.next != nil && tmp?.next != tail && i <= index {
//                tmp = tmp?.next
//                i += 1
//            }
        }
        
        return tmp!
    }
    
    @discardableResult
    public func remove(at index: Int) -> Element {
        let node = _node(at: index)
        node.prev?.next = node.next
        node.next?.prev = node.prev
        
        return node.element!
    }
    
    public func clear() {
        head?.next = nil
        tail?.prev = nil
        _size = 0
    }
    
    private func _checkBounds(_ index: Int) {
        if index < 0 || index > _size {
            fatalError("索引越界: \(index) out of bounds[0, \(_size))")
        }
    }
    
    private class Node<Element>: Equatable {
        
        var element: Element?
        var prev: Node<Element>?
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

extension DoubleLinkedList: CustomStringConvertible {
    public var description: String {
        
        var tmp = head
        var string = "size = \(size), head -> "
        while tmp?.next != nil {
            tmp = tmp?.next
            if let element = tmp?.element {
                string += "\(element) -> "
            } else {
                string += "tail -> "
            }
        }
        
        string.removeLast(3)
        string.append("\n")
        
        tmp = tail
        string.append("size = \(size), tail -> ")
        while tmp?.prev != nil {
            tmp = tmp?.prev
            if let element = tmp?.element {
                string += "\(element) -> "
            } else {
                string += "head -> "
            }
        }
        
        string.removeLast(3)
        
        return string
    }
}
