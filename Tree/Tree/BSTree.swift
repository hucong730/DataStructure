//
//  BSTree.swift
//  Tree
//
//  Created by 胡聪 on 2020/3/26.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Cocoa

public class BSTree<Element: Comparable>: BinaryTree<Element> {

    public func add(_ element: Element) {
        if root == nil {
            root = Node(element)
            _size += 1
            return
        }
        
        var node = root
        var parent = root
        while node != nil {
            parent = node
            if element > node!.element {
                node = node?.right
            } else if element < node!.element {
                node = node?.left
            } else {
                return
            }
        }
        
        let newNode = Node(element, parent: parent)
        if element > parent!.element {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        _size += 1
    }
    
    public func remove(_ element: Element) {
        let node = self.node(element)
        remove(node)
        _size -= 1
    }
    
    private func remove(_ node: Node<Element>?) {
        if node == nil {
            return
        }
        
        if node!.isLeaf {
            if node == node?.parent?.left {
                node?.parent?.left = nil
            } else if node == node?.parent?.right {
                node?.parent?.right = nil
            } else if node?.parent == nil {
                root = nil
            }
        } else if node!.is1Degree {
            let child = node!.left ?? node!.right
            if node == node?.parent?.left {
                child?.parent = node?.parent
                node?.parent?.left = child
            } else if node == node?.parent?.right {
                child?.parent = node?.parent
                node?.parent?.right = child
            } else if node == root {
                root = child
                child?.parent = nil
            }
            
        } else {
            let deleteNode = successor(node) ?? predecessor(node)
            node!.element = deleteNode!.element
            remove(deleteNode)
        }
    }
    
    private func node(_ element: Element) -> Node<Element>? {
        var node = root
        while node != nil {
            if element > node!.element {
                node = node?.right
            } else if element < node!.element {
                node = node?.left
            } else {
                return node
            }
        }
        return nil
    }
    
    func predecessor(_ node: Node<Element>?) -> Node<Element>? {

        var p = node?.left
        if p != nil {
            while p?.right != nil {
                p = p?.right
            }
            return p
        }
        
        var node = node
        while node?.parent != nil && node == node?.parent?.left {
            node = node?.parent
        }
        
        return node?.parent
    }
    
    func successor(_ node: Node<Element>?) -> Node<Element>? {
   
        var p = node?.right
        if p != nil {
            while p?.left != nil {
                p = p?.left
            }
            return p
        }
        
        var node = node
        while node?.parent != nil && node == node?.parent?.right {
            node = node?.parent
        }
        
        return node?.parent
    }
}
