//
//  FullZip.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

struct FullZip2Sequence<S0: SequenceType, S1: SequenceType> : SequenceType {
    
    let s0: S0
    let s1: S1
    
    func generate() -> FullZip2Generator<S0.Generator, S1.Generator> {
        return FullZip2Generator(e0: s0.generate(), e1: s1.generate())
    }
}

/// Just like the STL's Zip2Generator, but continues
/// until both generators are fully consumed
struct FullZip2Generator<E0: GeneratorType, E1: GeneratorType> : GeneratorType {
    
    var e0: E0
    var e1: E1
    
    mutating func next() -> (E0.Element?, E1.Element?)? {
        let tuple = (e0.next(), e1.next())
        return tuple.0 == nil && tuple.1 == nil ? nil : tuple
    }
}

func fullZip<S0 : SequenceType, S1 : SequenceType>(s0: S0, _ s1: S1) -> FullZip2Sequence<S0, S1> {
    return FullZip2Sequence(s0: s0, s1: s1)
}