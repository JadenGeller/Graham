//
//  Base.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

// Note that implementation details of Digit require Radix be less than sqrt(Backing.max)
// so make sure to choose an acceptably large Backing type!
public protocol Base {
    typealias Backing: IntegerType
    static var radix: Backing { get }
    static var representations: TypeMap<Backing, Character> { get }
}

/// Base 10
public struct Decimal: Base {
    public static let radix: Int8 = 10
    public static let representations = TypeMap(digitRepresentations(0..<10))
}

/// Base 2
public struct Binary: Base {
    public static let radix: Int8 = 2
    public static let representations = TypeMap(digitRepresentations(0..<2))
}

/// Base 16
public struct Hexadecimal: Base {
    public static let radix: Int8 = 16
    public static let representations = TypeMap(digitRepresentations(0..<10) + [10: "A", 11: "B", 12: "C", 13: "D", 14: "E", 15: "F"])
}

extension Character {
    private init(digitBacking: Int8) {
        self.init(String(digitBacking))
    }
}

func digitRepresentations(range: Range<Int8>) -> Zip2Sequence<Range<Int8>, [Character]> {
    return zip(range, range.map(Character.init))
}
