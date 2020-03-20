//
//  Stack.swift
//  Stack
//
//  Created by 胡聪 on 2020/3/20.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation


public class Stack<Element> {
    
    private var _size = 0
    private var _elements = [Element]()
    
    /// 栈的大小
    public var size: Int { _size }
    
    /// 栈是否为空
    public var isEmpty: Bool { _size == 0 }
    
    /// 入栈
    public func push(_ element: Element) {
        _elements.append(element)
        _size += 1
    }

    /// 出站
    @discardableResult
    public func pop() -> Element? {
        _size -= 1
        return _elements.popLast()
    }
    
    /// 栈顶
    public var top: Element? {
        _elements.last
    }

    /// 清空栈
    public func clear() {
        _size = 0
        _elements.removeAll()
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        var string = _elements.map { "\($0)" }.joined(separator: ", ")
        string.insert("[", at: string.startIndex)
        string.append("]")
        return string
    }
}
