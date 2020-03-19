//
//  LinkedList.swift
//  List
//
//  Created by 胡聪 on 2020/3/19.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation


public class LinkedList<Element>: List {
    
    /// 链表的头，
    private var head: Node<Element>? = Node<Element>(element: nil)
    
    private var _size = 0
    
    var size: Int {
        _size
    }
    
    subscript(index: Int) -> Element {
        get {
            return element(at: index)
        }
        set {
            insert(newValue, at: index)
        }
    }
    
    
    func append(_ element: Element) {
        
        insert(element, at: size)
    }
    
    func insert(_ element: Element, at index: Int) {
        var tmp = head
        var i = 0
        while tmp?.next != nil && i <= index {
            tmp = tmp?.next
            i += 1
        }
        
        let node = Node(element: element)
        node.next = tmp?.next
        tmp?.next = node
        
        _size += 1
    }
    
    func element(at index: Int) -> Element {
        var tmp = head
        var i = 0
        while i <= index {
            tmp = tmp?.next
            i += 1
        }
        
        return tmp!.element!
    }
    
    @discardableResult
    func remove(at index: Int) -> Element {
        var tmp = head
        var i = 0
        while tmp?.next != nil && i < index {
            tmp = tmp?.next
            i += 1
        }
        
        let next = tmp?.next
        tmp?.next = tmp?.next?.next
        _size -= 1
        
        return next!.element!
    }
    
    func clear() {
        head?.next = nil
        _size = 0
    }
    
    func reverse() {
        head?.next = _reverse(node: head?.next)
    }
    
    var hasCycle: Bool {
        
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
    
    class Node<Element>: Equatable {
        static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
            Unmanaged.passUnretained(lhs).toOpaque() == Unmanaged.passUnretained(rhs).toOpaque()
        }
        
        var element: Element?
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
