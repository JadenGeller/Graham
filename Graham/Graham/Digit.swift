//
//  Digit.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

extension Character {
    public init<B: Base>(digit: Digit<B>) {
        self.init(digit.description)
    }
}

public struct Digit<B: Base>: IntegerLiteralConvertible, CustomStringConvertible {
    private let backing: B.Backing

    init(_ value: B.Backing) {
        assert(value < B.radix, "Digit values must be less than the radix.")
        assert(value >= 0, "Digit values must be positive.")
        self.backing = value
    }
    
    init(_ representation: Character) {
        guard let digit = B.representations[representation] else {
            fatalError("Digit value must be valid character for the base.")
            
        }
        self.init(digit)
    }
    
    public init(integerLiteral value: B.Backing.IntegerLiteralType) {
        self.init(B.Backing(integerLiteral: value))
    }
    
    public var description: String {
        return String(B.representations[backing]!)
    }
}

extension Digit {
    
    static func complement(value: Digit) -> (digit: Digit, overflow: Bool) {
        if value == 0 {
            return (value, overflow: true)
        }
        else {
            return (Digit(B.radix - value.backing), overflow: false)
        }
    }
    
    static func add(lhs: Digit, _ rhs: Digit) -> (sum: Digit, carry: Digit) {
        let sum = lhs.backing + rhs.backing
        return (sum: Digit(sum % B.radix), carry: Digit(sum / B.radix))
    }
    
    static func subtract(lhs: Digit, _ rhs: Digit) -> (difference: Digit, borrow: Digit) {
        guard rhs != 0 else { return (difference: lhs, borrow: 0) }
        let result = add(lhs, complement(rhs).digit)
        return (result.sum, result.carry.predecessor())
    }
    
    static func multiply(lhs: Digit, _ rhs: Digit) -> (product: Digit, carry: Digit) {
        let product = lhs.backing * rhs.backing
        return (product: Digit(product % B.radix), carry: Digit(product / B.radix))
    }
    
    static func divide(lhs: Digit, _ rhs: Digit) -> (quotient: Digit, remainder: Digit) {
        return (quotient: Digit((lhs.backing / rhs.backing) % B.radix), remainder: Digit((lhs.backing % rhs.backing) % B.radix))
    }
}

extension Digit: IntegerArithmeticType {
    public static func addWithOverflow(lhs: Digit, _ rhs: Digit) -> (Digit, overflow: Bool) {
        let result = add(lhs, rhs)
        return (result.sum, result.carry != 0)
    }
    
    public static func subtractWithOverflow(lhs: Digit, _ rhs: Digit) -> (Digit, overflow: Bool) {
        let result = subtract(lhs, rhs)
        return (result.difference, result.borrow != 0)
    }
    
    public static func multiplyWithOverflow(lhs: Digit, _ rhs: Digit) -> (Digit, overflow: Bool) {
        let result = multiply(lhs, rhs)
        return (result.product, result.carry != 0)
    }
    
    public static func divideWithOverflow(lhs: Digit, _ rhs: Digit) -> (Digit, overflow: Bool) {
        let result = divide(lhs, rhs)
        return (result.quotient, false)
    }
    
    public static func remainderWithOverflow(lhs: Digit, _ rhs: Digit) -> (Digit, overflow: Bool) {
        let result = divide(lhs, rhs)
        return (result.remainder, false)
    }

    public func toIntMax() -> IntMax {
        return backing.toIntMax()
    }
}

public func ==<B>(lhs: Digit<B>, rhs: Digit<B>) -> Bool {
    return lhs.backing == rhs.backing
}

public func <<B>(lhs: Digit<B>, rhs: Digit<B>) -> Bool {
    return lhs.backing < rhs.backing
}

extension Digit: BidirectionalIndexType {
    public func successor() -> Digit {
        return Digit(backing + 1)
    }
    
    public func predecessor() -> Digit {
        return Digit(backing - 1)
    }
}


