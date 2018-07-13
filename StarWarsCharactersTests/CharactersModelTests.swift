//
//  CharactersModelTests.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 6/13/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import StarWarsCharacters

class CharactersModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExampleEmptyCharacters() {
        let data = Data()
        let completion : ((Result<CharactersModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testParseCharacters() {
        guard let data = FileManager.readJson(forResource: "Person") else {
            XCTAssert(false, "Can't get data from Person.json")
            return
        }
        let completion : ((Result<CharactersModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid converter")
            case .success(let converter):
                XCTAssertEqual(converter.count, 87, "Expected 87 count")
                XCTAssertEqual(converter.next, "https://swapi.co/api/people/?page=2", "Expected https://swapi.co/api/people/?page=2 next")
                XCTAssertEqual(converter.previous, "", "")
                XCTAssertEqual(converter.results.count, 10, "Expected 10 results")
            }
        }
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testWrongKeyCharacters() {
        let dictionary = ["testObject" : 123 as AnyObject]
        let result = CharactersModel.parseObject(dictionary: dictionary)
        switch result {
        case .success(_):
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }

}
