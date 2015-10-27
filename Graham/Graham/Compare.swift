//
//  Compare.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

public enum ComparisonResult {
    case LessThan
    case GreaterThan
    case Equal
}

extension ComparisonResult {
    internal var negated: ComparisonResult {
        switch self {
        case .LessThan:    return .GreaterThan
        case .GreaterThan: return .LessThan
        case .Equal:       return .Equal
        }
    }
}

infix operator <=> { associativity none precedence 130 }
public func <=><C: Comparable>(lhs: C, rhs: C) -> ComparisonResult {
    if      lhs < rhs { return .LessThan }
    else if lhs > rhs { return .GreaterThan }
    else              { return .Equal }
}
