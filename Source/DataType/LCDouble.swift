//
//  LCDouble.swift
//  LeanCloud
//
//  Created by Tang Tianyong on 2/27/16.
//  Copyright © 2016 LeanCloud. All rights reserved.
//

import Foundation

/**
 LeanCloud double type.

 It is a wrapper of Double type, used to store a double value.
 */
public class LCDouble: LCType {
    public private(set) var value: Double?

    public required init() {
        super.init()
    }

    public convenience init(_ value: Double) {
        self.init()
        self.value = value
    }

    public override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! LCDouble
        copy.value = self.value
        return copy
    }

    override class func operationReducerType() -> OperationReducer.Type {
        return OperationReducer.Number.self
    }

    /**
     Increase value by specified amount.

     - parameter amount: The amount to increase.
     */
    public func increaseBy(amount: Double) {
        updateParent { (object, key) -> Void in
            object.addOperation(.Increment, key, LCDouble(amount))
        }
    }

    /**
     Increase value by 1.
     */
    public func increase() {
        increaseBy(1)
    }

    // MARK: Arithmetic

    override func add(another: LCType?) -> LCType? {
        guard let another = another as? LCDouble else {
            /* TODO: throw an exception that two type cannot be added. */
            return nil
        }

        let base = self.value ?? 0.0
        let increment = another.value ?? 0.0

        return LCDouble(base + increment)
    }
}