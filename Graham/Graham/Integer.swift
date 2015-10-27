//
//  Integer.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

typealias BigInt = Integer<Decimal>

public struct Integer<B: Base> {
    public let digits: [Digit<B>]
    public let sign: Sign
}

extension Integer: IntegerLiteralConvertible, StringLiteralConvertible {
    
    private init<S: SequenceType where S.Generator.Element == Character>(characters: S, sign: Sign) {
        let digits = Array(characters.dropWhile{ $0 == "0" }.reverse().map(Digit<B>.init))
        self.init(digits: digits, sign: digits.isEmpty ? .Positive : sign) // Zero is always positive
    }
    
    public init(stringLiteral value: String) {
        if value.characters.first! == "-" {
            self.init(characters: value.characters.dropFirst(), sign: .Negative)
        }
        else if value.characters.first! == "+" {
            self.init(characters: value.characters.dropFirst(), sign: .Positive)
        }
        else {
            self.init(characters: value.characters, sign: .Positive)
        }
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(_ value: IntMax) {
        self.init(characters: String(abs(value)).characters, sign: value >= 0 ? Sign.Positive : Sign.Negative)
    }
    
    public init(integerLiteral value: IntMax) {
        self.init(value)
    }
}

extension Integer: CustomStringConvertible {
    public var description: String {
        if self == 0 {
            return "0"
        } else {
            return ((self < 0) ? "-" : "") + digits.reduce("", combine: { $1.description + $0 })
        }
    }
}

extension Integer: Comparable { }

func <=><B: Base>(lhs: Integer<B>, rhs: Integer<B>) -> ComparisonResult {
    let sign = lhs.sign <=> rhs.sign
    guard case .Equal = sign else { return sign }
    
    let negative = lhs.sign == .Negative // == rhs.sign
    
    let count = lhs.digits.count <=> rhs.digits.count
    guard case .Equal = count else { return negative ? count.negated : count }
    
    for (l, r) in zip(lhs.digits, rhs.digits).reverse() {
        let digit = l <=> r
        guard case .Equal = digit else { return negative ? digit.negated : digit }
    }
    
    return .Equal
}

public func ==<B: Base>(lhs: Integer<B>, rhs: Integer<B>) -> Bool {
    return (lhs <=> rhs) == .Equal
}

public func <<B: Base>(lhs: Integer<B>, rhs: Integer<B>) -> Bool {
    return (lhs <=> rhs) == .LessThan
}

//
//struct Integer2<B : Base> : Printable, DebugPrintable, IntegerLiteralConvertible, Strideable, SignedNumberType, SequenceType, IntegerArithmeticType, Hashable, BidirectionalIndexType, StringLiteralConvertible {
//    
//    init(var decimalValue value: IntMax) {
//        let radix = IntMax(B.radix)
//        
//        let sign: IntegerSign = value < 0 ? .Negative : .Positive
//        value = abs(value)
//        
//        var num = ""
//        while value > 0 {
//            let digit = Digit<B>.representationForValue(UInt8(value % radix))
//            num.insert(digit, atIndex: num.startIndex)
//            value = value / radix
//        }
//        self.init(string: num, sign: sign)
//    }
//    
//    
//    
//    
//    
//   
//    
//    private init(var backing: [Digit<B>], sign: IntegerSign) {
//        // Remove leading zeros
//        while let msb = backing.last where msb.isZero { backing.removeLast() }
//        
//        self.backing = backing
//        self.sign = sign
//    }
//    
//    func advancedBy(value: Integer<B>) -> Integer<B> {
//        return Integer.addWithOverflow(self, value).0
//    }
//    
//    func distanceTo(other: Integer<B>) -> Integer<B> {
//        return Integer.subtractWithOverflow(other, self).0
//    }
//    
//    func successor() -> Integer<B> {
//        return self.advancedBy(Integer(1))
//    }
//    
//    func predecessor() -> Integer<B> {
//        return self.advancedBy(Integer(-1))
//    }
//    
//    func shift(count: Integer<B>) -> Integer<B> {
//        if      count.isPositive { return shiftRight(count) }
//        else if count.isNegative { return shiftLeft(count.negated) }
//        else                     { return self }
//    }
//    
//    func shiftRight(count: Integer<B>) -> Integer<B> {
//        assert(count > 0, "Cannot shift right by a non-positive count")
//        
//        var backing = self.backing
//        for _ in 1...count {
//            if backing.count == 0 { break }
//            backing.removeAtIndex(0)
//        }
//        return Integer(backing: backing, sign: sign)
//    }
//    
//    func shiftLeft(count: Integer<B>) -> Integer<B> {
//        assert(count > 0, "Cannot shift left by a non-positive count")
//        
//        var backing = self.backing
//        for _ in 1...count {
//            backing.insert(Digit.zero, atIndex: 0)
//        }
//        return Integer(backing: backing, sign: sign)
//    }
//    
//    var negated: Integer<B> {
//        get {
//            return Integer(backing: backing, sign: sign.opposite)
//        }
//    }
//    
//    var isZero: Bool {
//        get {
//            return backing.reduce(true, combine: { lhs, rhs in lhs && rhs.isZero })
//        }
//    }
//    
//    var description: String {
//        get {
//            
//        }
//    }
//    
//    var debugDescription: String {
//        get {
//            return description
//        }
//    }
//    
//    var hashValue: Int {
//        get {
//            return reduce(self, 0, { total, digit in total &+ digit.hashValue })
//        }
//    }
//    
//    func generate() -> GeneratorOf<Digit<B>> {
//        return GeneratorOf(backing.generate())
//    }
//    
//    func toIntMax() -> IntMax {
//        fatalError("To implement")
//    }
//    
//    static func addWithOverflow(lhs: Integer<B>, _ rhs: Integer<B>) -> (Integer<B>, overflow: Bool) {
//        switch (lhs.isNegative, rhs.isNegative) {
//        case (true, true):  return (addWithOverflow(rhs.negated, lhs.negated).0.negated, false)
//        case (false, true): return (subtractWithOverflow(lhs, rhs.negated).0, false)
//        case (true, false): return (subtractWithOverflow(rhs, lhs.negated).0, false)
//        default:
//            if rhs.isNegative { return (subtractWithOverflow(lhs, rhs.negated).0, false) }
//            
//            var backing = [Digit<B>]()
//            var carry = Digit<B>.zero
//            for (l, r) in weakZip(lhs, rhs) {
//                if l == nil && r == nil { break }
//                
//                let (digit, newCarry) = Digit.addWithDigitOverflow(l ?? Digit.zero, r ?? Digit.zero, carry: carry)
//                carry = newCarry
//                backing.append(digit)
//            }
//            if !carry.isZero { backing.append(carry) }
//            
//            return (Integer(backing: backing, sign: .Positive), false)
//        }
//    }
//    
//    static func subtractWithOverflow(lhs: Integer<B>, _ rhs: Integer<B>) -> (Integer<B>, overflow: Bool) {
//        if rhs.isNegative { return (addWithOverflow(lhs, rhs.negated).0, false) }
//        if lhs < rhs { return (subtractWithOverflow(rhs, lhs).0.negated, false) }
//        
//        var backing = [Digit<B>]()
//        var borrow = Digit<B>.zero
//        for (l, r) in weakZip(lhs, rhs) {
//            if l == nil && r == nil { break }
//            
//            let (digit, newBorrow) = Digit.subtractWithDigitUnderflow(l ?? Digit.zero, r ?? Digit.zero, borrow: borrow)
//            borrow = newBorrow
//            backing.append(digit)
//        }
//        
//        return (Integer(backing: backing, sign: .Positive), false)
//    }
//    
//    private static func multiply(lhs: Integer<B>, _ rhs: Digit<B>) -> Integer<B> {
//        
//        var backing = [Digit<B>]()
//        
//        var carry = Digit<B>.zero
//        for n in lhs {
//            
//            let (rawDigit, newCarryMutiplication) = Digit.multiplyWithDigitOverflow(n, rhs)
//            let (digit, newCarryAddition) = Digit.addWithDigitOverflow(rawDigit, carry, carry: 0)
//            
//            carry = newCarryMutiplication + newCarryAddition
//            backing.append(digit)
//        }
//        if !carry.isZero { backing.append(carry) }
//        
//        return Integer(backing: backing, sign: .Positive)
//        
//    }
//    
//    static func multiplyWithOverflow(lhs: Integer<B>, _ rhs: Integer<B>) -> (Integer<B>, overflow: Bool) {
//        var total: Integer = 0
//        
//        for (index, digit) in enumerate(rhs) {
//            if digit == 0 { continue } // optimization
//            total += multiply(lhs, digit) << Integer(decimalValue: IntMax(index))
//        }
//        
//        return (Integer(backing: total.backing, sign: IntegerSign.multiply(lhs.sign, rhs: rhs.sign)), false)
//    }
//    
//    static func slowDivide(var numerator: Integer<B>, _ denominator: Integer<B>) -> (quotient: Integer<B>, remainder: Integer<B>) {
//        var count: Integer<B> = 0
//        
//        while !numerator.isNegative {
//            numerator -= denominator
//            count++
//        }
//        
//        // We went over once it became negative, so backtrack
//        count--
//        numerator += denominator
//        
//        return (count, numerator)
//    }
//    
//    static func longDivide(numerator: Integer<B>, _ denominator: Integer<B>) -> (quotient: Integer<B>, remainder: Integer<B>) {
//        var end = numerator.backing.endIndex
//        var start = end - denominator.backing.count
//        
//        while start >= numerator.backing.startIndex {
//            let range = start..<end
//            let smallNum = Integer(backing: Array(numerator.backing[range]), sign: .Positive)
//            let (quotient, remainder) = slowDivide(smallNum, denominator)
//            
//            if !quotient.isZero {
//                // We can divide!
//                
//                var numeratorBacking = numerator.backing
//                numeratorBacking[range] = remainder.backing[0..<(remainder.backing.count)]
//                let newNumerator = Integer(backing: numeratorBacking, sign: .Positive)
//                
//                let value = quotient << Integer(decimalValue: IntMax(start))
//                if newNumerator.isZero {
//                    return (value, 0)
//                }
//                else {
//                    let (recursiveQuotient, recursiveRemainder) = longDivide(newNumerator, denominator)
//                    return (value + recursiveQuotient, recursiveRemainder)
//                }
//            }
//            
//            start--
//        }
//        
//        return (0, numerator)
//    }
//    
//    static func divideWithOverflow(lhs: Integer<B>, _ rhs: Integer<B>) -> (Integer<B>, overflow: Bool) {
//        if rhs.isZero { fatalError("division by zero") }
//        return (longDivide(lhs, rhs).quotient, false)
//    }
//    
//    static func remainderWithOverflow(lhs: Integer<B>, _ rhs: Integer<B>) -> (Integer<B>, overflow: Bool) {
//        if rhs.isZero { fatalError("division by zero") }
//        return (longDivide(lhs, rhs).remainder, false)
//    }
//    
//    func convertBase<T>() -> Integer<T> {
//        var num: Integer<T> = 0
//        var muliplier: Integer<T> = 1
//        var radix = Integer<T>(decimalValue: IntMax(B.radix))
//        
//        for digit in backing {
//            num += Integer<T>(decimalValue: IntMax(digit.backing)) * muliplier
//            muliplier *= radix
//        }
//        
//        return num
//    }
//    
//}