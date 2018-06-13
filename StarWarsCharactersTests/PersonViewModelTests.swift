//
//  PersonViewModelTests.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 6/13/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import StarWarsCharacters

class PersonViewModelTests: XCTestCase {
    fileprivate class MockFeedsService: CharactersRouterProtocol {
        var feedsData: CharactersModel?
        func fetchConverter(_ completion: @escaping ((Result<CharactersModel, ErrorResult>) -> Void)) {
            if let data = feedsData {
                completion(Result.success(data))
            } else {
                completion(Result.failure(ErrorResult.custom(string: "No converter")))
            }
        }
    }
    
    var viewModel : PersonViewModel!
    var dataSource : GenericDataSource<PersonModel>!
    fileprivate var service : MockFeedsService!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
}
