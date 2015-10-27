//
//  Map.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

/// A bidirectional dictionary between values of different types
public struct TypeMap<First: Hashable, Second: Hashable> {
    private var firstBacking = [First : Second]()
    private var secondBacking = [Second : First]()
    
    public init<S: SequenceType where S.Generator.Element == (First, Second)>(_ sequence: S) {
        for (first, second) in sequence {
            firstBacking[first] = second
            secondBacking[second] = first
        }
    }
    
    public subscript(first: First) -> Second? {
        get {
            return firstBacking[first]
        }
    }
    
    public subscript(second: Second) -> First? {
        get {
            return secondBacking[second]
        }
    }
}