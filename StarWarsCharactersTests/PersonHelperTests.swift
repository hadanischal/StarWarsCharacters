//
//  PersonHelperTests.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 26/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import StarWarsCharacters

class PersonHelperTests: XCTestCase {

    private var personHelper: PersonHelper!

    override func setUp() {
        self.personHelper = PersonHelper()
    }

    override func tearDown() {
        self.personHelper = nil
    }

    func testParseWithEyeColor() {
        let mockValue = MockData.shared.getPersonModel() ?? []
        let mockEyeList = MockData.shared.getEyeColorModelWithAll()

        let result =  personHelper.parseEyeColorArray(results: mockValue)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, mockEyeList)
    }

    //not equal if not added all section
    func testParseWithEyeColorNotEqual() {
        let mockValue = MockData.shared.getPersonModel() ?? []
        let mockEyeList = MockData.shared.getEyeColorModel()

        let result =  personHelper.parseEyeColorArray(results: mockValue)
        XCTAssertNotNil(result)
        XCTAssertNotEqual(result, mockEyeList)
    }

}
