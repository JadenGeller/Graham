//
//  GrahamTests.swift
//  GrahamTests
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

import XCTest
@testable import Graham

class DigitTests: XCTestCase {
    
    func testAddZero() {
        let target: Digit<Decimal> = 9
        XCTAssertEqual(target, 0 + 9 as Digit)
        XCTAssertEqual(target, 9 + 0 as Digit)
    }
    
    func testAdd() {
        let target: Digit<Decimal> = 8
        XCTAssertEqual(target, 3 + 5 as Digit)
        XCTAssertEqual(target, 5 + 3 as Digit)
        XCTAssertEqual(target, 1 + 7 as Digit)
        XCTAssertEqual(target, 7 + 1 as Digit)
    }
    
    func testSubtractZero() {
        let target: Digit<Decimal> = 9
        XCTAssertEqual(target, 9 - 0 as Digit)
    }
    
    func testSubtract() {
        let target: Digit<Decimal> = 3
        XCTAssertEqual(target, 8 - 5 as Digit)
        XCTAssertEqual(target, 7 - 4 as Digit)
    }
    
    func testMultiply() {
        let target: Digit<Decimal> = 8
        XCTAssertEqual(target, 2 * 4 as Digit)
        XCTAssertEqual(target, 4 * 2 as Digit)
        XCTAssertEqual(target, 8 * 1 as Digit)
        XCTAssertEqual(target, 1 * 8 as Digit)
    }
    
    func testDivide() {
        let target: Digit<Decimal> = 3
        XCTAssertEqual(target, 9 / 3 as Digit)
    }
    
    func testRemainder() {
        let target: Digit<Decimal> = 1
        XCTAssertEqual(target, 9 % 2 as Digit)
    }
    
    func testHex() {
        let target: Digit<Hexadecimal> = 10
        XCTAssertEqual("A", target.description)
        XCTAssertEqual(target, Digit<Hexadecimal>("A"))
    }
    
    func testEquals() {
        let five: Digit<Decimal> = 5
        let three: Digit<Decimal> = 3
        XCTAssertEqual(true, five > three)
        XCTAssertEqual(true, five != three)
    }
}
