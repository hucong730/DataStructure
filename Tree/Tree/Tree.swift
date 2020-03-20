//
//  Tree.swift
//  Tree
//
//  Created by 胡聪 on 2020/3/20.
//  Copyright © 2020 胡聪. All rights reserved.
//

import Foundation

public protocol Tree {
    
    associatedtype E

    var size: Int { get }
    var height: Int { get }
    
    var isEmpty: Bool { get }
    
    
    
}

extension Tree {
    public var isEmpty: Bool { size == 0 }
}
