//
//  Sign.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public enum Sign {
    case Positive
    case Negative
    
    internal var flipped: Sign {
        switch self {
        case .Positive: return .Negative
        case .Negative: return .Positive
        }
    }
    
    internal static func multiply(lhs: Sign, rhs: Sign) -> Sign {
        return lhs == rhs ? .Positive : .Negative
    }
}

extension Sign: Comparable { }

public func <(lhs: Sign, rhs: Sign) -> Bool {
    return lhs == .Negative && rhs == .Positive
}