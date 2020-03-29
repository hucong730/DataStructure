//
//  BinaryTree.swift
//  Tree
//
//  Created by 胡聪 on 2020/3/20.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation


public class BinaryTree<Element>: Tree {
    
    public typealias E = Element
    
    var root: Node<Element>?
    
    var _size = 0
    
    public var size: Int { _size }
    
    public var height: Int {
        _getHeight(node: root)
    }
    
    
    public func preorderTraversal() -> [Element] {
        
        if root == nil {
            return []
        }
        
        var stack = [Node<Element>]()
        var array = [Element]()
        stack.append(root!)
        
        while !stack.isEmpty {
            let node = stack.removeLast()
            array.append(node.element)
            
            if node.right != nil {
                stack.append(node.right!)
            }
            
            if node.left != nil  {
                stack.append(node.left!)
            }
        }
        
        return array
        
    }
    public func inorderTraversal() -> [Element] {
        if root == nil {
            return []
        }
        
        var stack = [Node<Element>]()
        var array = [Element]()

        var node = root
        
        while true {
            if node != nil {
                stack.append(node!)
                node = node?.left
            } else {
                if stack.isEmpty {
                    break
                } else {
                    node = stack.removeLast()
                    array.append(node!.element)
                }
                node = node?.right
            }
        }
        
        return array
    }
    
    public func postorderTraversal() -> [Element] {
        if root == nil {
            return []
        }
        
        var stack = [Node<Element>]()
        var array = [Element]()
        stack.append(root!)
        var last: Node<Element>?
        while !stack.isEmpty {
            let top = stack.last!
            if top.isLeaf || (top.left == last || top.right == last) && last != nil {
                last = stack.removeLast()
                array.append(last!.element)
            } else {
                if top.right != nil {
                    stack.append(top.right!)
                }
                if top.left != nil {
                    stack.append(top.left!)
                }
            }
        }
        
        
        return array
    }
    
    private func postorderTraversal2() -> [Element] {
        if root == nil {
            return []
        }
        
        var stack = [Node<Element>]()
        var output = [Node<Element>]()
        var node = root
        while node != nil || !stack.isEmpty {
            if node != nil {
                stack.append(node!)
                output.append(node!)
                node = node?.right
            } else {
                node = stack.removeLast()
                node = node?.left
            }
        }
        
        var array = [Element]()
        while !output.isEmpty {
            let node = output.removeLast()
            array.append(node.element)
        }
        
        return array
    }
    
    public func levelOrderTraversal() -> [Element] {
        if root == nil {
            return []
        }
        
        var queue = [Node<Element>]()
        var array = [Element]()
        queue.append(root!)
        
        
        var height = 0 //树的高度
        var count = 1 //每一层节点的数量
        while !queue.isEmpty {
            let peek = queue.removeFirst()
            array.append(peek.element)
            
            if peek.left != nil {
                queue.append(peek.left!)
            }
            
            if peek.right != nil {
                queue.append(peek.right!)
            }
            
            count -= 1
            if count == 0 {
                count = queue.count
                height += 1
            }
        }
        return array
    }
    
    func add(node: Node<Element>, parent: Node<Element>? = nil, orientation: TreeOrientation = .default) {
        if root == nil {
            root = node
            return
        }
        
        switch orientation {
        case .left:
            parent?.left = node
        case .right:
            parent?.right = node
        default:
            if parent?.left == nil {
                parent?.left = node
            } else {
                parent?.right = node
            }
            
        }
        _size += 1
    }
    
    private func _getHeight(node: Node<Element>?) -> Int {
        if node == nil {
            return 0
        }
        
        let left = _getHeight(node: node?.left)
        let right = _getHeight(node: node?.right)
        return max(left, right) + 1
    }
    
    private func _createRoot(_ element: Element) {
        root = Node(element)
    }
}


class Node<Element>: Equatable, CustomStringConvertible {
    var element: Element
    var left: Node<Element>?
    var right: Node<Element>?
    
    var parent: Node<Element>?
    
    var is1Degree: Bool {
        (left == nil && right != nil) || (right == nil && left != nil)
    }
    
    var is2Degree: Bool {
        left != nil && right != nil
    }
    
    init(_ element: Element, parent: Node<Element>? = nil) {
        self.element = element
        self.parent = parent
    }
    
    static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        Unmanaged.passUnretained(lhs).toOpaque() == Unmanaged.passUnretained(rhs).toOpaque()
    }
    
    var isLeaf: Bool {
        left == nil && right == nil
    }
    
    var description: String {
        return "\(element)"
    }
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        var string = "树的高度 = \(height), 节点数量 = \(size)\n"
        string.append("前序遍历: \(preorderTraversal())\n")
        string.append("中序遍历: \(inorderTraversal())\n")
        string.append("后序遍历: \(postorderTraversal())\n")
        string.append("后序遍历2: \(postorderTraversal2())\n")
        string.append("层序遍历: \(levelOrderTraversal())\n")
        return string
    }
}

enum TreeOrientation {
    case `default`
    case left
    case right
}
