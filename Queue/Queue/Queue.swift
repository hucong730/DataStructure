//
//  Queue.swift
//  Queue
//
//  Created by 胡聪 on 2020/3/20.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation


public class Queue<Element> {
    private var _size = 0
    private var _elements = [Element]()
    
    private lazy var _lock = NSLock()
    
    /// 队列的大小
    public var size: Int { _size }
    
    /// 队列是否为空
    public var isEmpty: Bool { _size == 0 }
    
    /// 入队
    public func enQueue(_ element: Element) {
        _lock.lock()
        defer {
            _lock.unlock()
        }
        _elements.append(element)
        _size += 1
        
    }

    /// 出队
    @discardableResult
    public func deQueue() -> Element? {
        if _size == 0 {
            return nil
        }
        _lock.lock()
        defer {
            _lock.unlock()
        }
        _size -= 1
        return _elements.removeFirst()
    }
    
    /// 队头
    public var peek: Element? {
        _elements.first
    }

    /// 清空队列
    public func clear() {
        _size = 0
        _elements.removeAll()
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        var string = "size = \(size), elements = ["
        string += _elements.map { "\($0)" }.joined(separator: ", ")
        string.append("]")
        return string
    }
}
