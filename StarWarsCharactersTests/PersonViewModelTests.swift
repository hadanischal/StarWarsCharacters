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
        var charactersData: CharactersModel?
        func fetchConverter(_ completion: @escaping ((Result<CharactersModel, ErrorResult>) -> Void)) {
            if let data = charactersData {
                completion(Result.success(data))
            } else {
                completion(Result.failure(ErrorResult.custom(string: "No converter")))
            }
        }
    }

    var viewModel: PersonViewModel!
    var dataSource: GenericDataSource<PersonModel>!
    fileprivate var service: MockFeedsService!

    override func setUp() {
        super.setUp()
        self.service = MockFeedsService()
        self.dataSource = GenericDataSource<PersonModel>()
        self.viewModel = PersonViewModel(service: service, dataSource: dataSource)
    }

    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }

    func testFetchCharacters() {
        let dictionary: [String: Any] = [:]
        guard let result = CharactersModel.init(json: dictionary)else {
            XCTAssert(false, "ViewModel should not be able to fetch without CharactersModel")
            return
        }
        service?.charactersData = result
        viewModel.fetchServiceCall { result in
            switch result {
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default: break
            }
        }
    }

    func testFetchNoCharacters() {
        service.charactersData = nil
        viewModel.fetchServiceCall { result in
            switch result {
            case .success :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default: break
            }
        }
    }

}
