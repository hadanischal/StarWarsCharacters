//
//  PersonDataSourceTests.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 6/13/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import StarWarsCharacters

class PersonDataSourceTests: XCTestCase {
    var dataSource : PersonDataSource!

    override func setUp() {
        super.setUp()
        dataSource = PersonDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
