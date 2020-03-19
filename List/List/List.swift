//
//  List.swift
//  List
//
//  Created by 胡聪 on 2020/3/19.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation


/// 链表
public protocol List {
    
    associatedtype E
    
    typealias Element = E
    
    /// 链表的大小
    var size: Int { get }
    
    /// 链表是否为空
    var isEmpty: Bool { get }
    
    /// 根据索引来获取或者插入元素
    subscript(index: Int) -> Element { get set }
    
    /// 往链表的尾部追加元素
    func append(_ element: Element)
    
    /// 在索引index的位置插入元素
    func insert(_ element: Element, at index: Int)
    
    /// 移除索引为index处的元素，并返回它
    @discardableResult
    func remove(at index: Int) -> Element

    /// 清空链表
    func clear()
}

extension List {
    public var isEmpty: Bool { size == 0 }
}
