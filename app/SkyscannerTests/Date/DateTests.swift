//
//  DateTests.swift
//  SkyscannerTests
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import XCTest
@testable import Skyscanner

class DateTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNextMondayFromToday() {
        let nextMondayFromToday = Date.today().next(.monday).getStringyyyyMMddFormat()
        let today = Date.today().getStringyyyyMMddFormat()
        XCTAssert(nextMondayFromToday != today, "Error getting the next Monday")
    }
    
    func testNextTuesdayFromToday() {
        let nextMondayFromToday = Date.today().next(.monday)
        let nextTuesdayFromToday = nextMondayFromToday.add(days: 1).getStringyyyyMMddFormat()
        let today = Date.today().getStringyyyyMMddFormat()
        XCTAssert(nextTuesdayFromToday != today, "Error getting the next Tuesday")
    }

}
