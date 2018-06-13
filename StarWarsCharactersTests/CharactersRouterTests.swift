//
//  CharactersRouterTests.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 6/13/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import StarWarsCharacters

class CharactersRouterTests: XCTestCase {
    
    func testCancelRequest() {
        let service : CharactersRouter! = CharactersRouter()
        service.fetchConverter{ (_) in
        }
        service.cancelFetchCurrencies()
        XCTAssertNil(service.task, "Expected task nil")
    }
}
