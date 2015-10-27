//
//  Concatenate.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

struct ConcatenatedSequence<S0: SequenceType, S1: SequenceType where S0.Generator.Element == S1.Generator.Element> : SequenceType {
    
    let s0: S0
    let s1: S1
    
    func generate() -> ConcatenatedGenerator2<S0.Generator, S1.Generator> {
        return ConcatenatedGenerator2(e0: s0.generate(), e1: s1.generate())
    }
}

struct ConcatenatedGenerator2<E0: GeneratorType, E1: GeneratorType where E0.Element == E1.Element> : GeneratorType {
    
    var e0: E0
    var e1: E1
    
    mutating func next() -> E0.Element? {
        return e0.next() ?? e1.next()
    }
}

func +<S0: SequenceType, S1: SequenceType where S0.Generator.Element == S1.Generator.Element>(lhs: S0, rhs: S1) -> ConcatenatedSequence<S0, S1> {
    return ConcatenatedSequence(s0: lhs, s1: rhs)
}