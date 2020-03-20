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
    
    private lazy var _lock = NSLock()
    
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
        _lock.lock()
        defer {
            _lock.unlock()
        }
        let node = _node(at: index)
        let newNode = Node(element: element)
        newNode.prev = node
        newNode.next = node.next
        node.next?.prev = newNode
        node.next = newNode

        _size += 1
    }
    
    private func _node(at index: Int) -> Node<Element> {
        _checkBounds(index)
        
        let half = _size >> 1
        var tmp = head
        if index > half { //从尾部开始遍历
            tmp = tail
            for _ in stride(from: _size, to: index - 1, by: -1) {
                tmp = tmp?.prev
            }
        } else { //从头部开始遍历
            for _ in 0..<index {
                tmp = tmp?.next
            }
        }
        
        return tmp!
    }
    
    @discardableResult
    public func remove(at index: Int) -> Element {
        _lock.lock()
        defer {
            _lock.unlock()
        }
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
    
    private class Node<Element> {
        
        var element: Element?
        var prev: Node<Element>?
        var next: Node<Element>?
        
        init(element: Element?) {
            self.element = element
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
