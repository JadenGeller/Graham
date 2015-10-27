//
//  IntegerTests.swift
//  Graham
//
//  Created by Jaden Geller on 10/26/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//

import XCTest
@testable import Graham

class IntegerTests: XCTestCase {

    func testInitialization() {
        XCTAssertEqual("123456789", (123456789 as BigInt).description)
        XCTAssertEqual("123456789", ("123456789" as BigInt).description)
        XCTAssertEqual("-10010001", (-010010001 as BigInt).description)
        XCTAssertEqual("-10010001", ("-010010001" as BigInt).description)
    }
    
    func testComparable() {
        XCTAssertFalse((56789 as BigInt) > (56789 as BigInt))
        XCTAssertTrue((6789 as BigInt) < (56789 as BigInt))
        XCTAssertTrue((16789 as BigInt) < (56789 as BigInt))
        XCTAssertTrue((116789 as BigInt) > (56789 as BigInt))
        XCTAssertTrue((1000000 as BigInt) > (1 as BigInt))
        XCTAssertTrue((-1000000 as BigInt) < (1 as BigInt))
        XCTAssertFalse((-1000000 as BigInt) < (-1000000 as BigInt))
        XCTAssertTrue((-1 as BigInt) > (-1000000 as BigInt))
    }
}