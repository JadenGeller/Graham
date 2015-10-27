//
//  Drop.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

extension SequenceType {
    
    /// Creates a new sequence by dropping the prefix that satisfies `condition`
    func dropWhile(condition: Generator.Element -> Bool) -> AnySequence<Generator.Element> {
        var generator = generate()
        var alreadyDropped = false
        return AnySequence(anyGenerator {
            while true {
                guard let next = generator.next() else { return nil }
                if !alreadyDropped && condition(next) { continue }
                alreadyDropped = true
                return next
            }
        })
    }
}