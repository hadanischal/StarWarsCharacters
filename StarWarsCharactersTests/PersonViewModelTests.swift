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
    var viewModel: PersonViewModel!
    var dataSource: GenericDataSource<PersonModel>!
    fileprivate var mockService: MockCharactersRouter!
    private var mockPersonHelper: MockPersonHelper!

    override func setUp() {
        super.setUp()
        self.mockService = MockCharactersRouter()
        self.mockPersonHelper = MockPersonHelper()
        self.dataSource = GenericDataSource<PersonModel>()
        self.viewModel = PersonViewModel(service: mockService, withPersonHelper: mockPersonHelper, dataSource: dataSource)
    }

    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.mockService = nil
        super.tearDown()
    }

    func testFetchCharacters() {
        let characterData = MockData().getCharactersModel()
        guard let result = characterData else {
            XCTAssert(false, "ViewModel should not be able to fetch without CharactersModel")
            return
        }
        mockService?.charactersData = result
        viewModel.fetchServiceCall { result in
            switch result {
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default: break
            }
        }
    }

    func testFetchNoCharacters() {
        mockService.charactersData = nil
        viewModel.fetchServiceCall { result in
            switch result {
            case .success :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default: break
            }
        }
    }

    func testFetchCharactersEyeList() {
        let exp = expectation(description: "Loading service call")
        self.mockService.charactersData = MockData.shared.getCharactersModel()
        self.mockPersonHelper.eyeColorData = MockData.shared.getEyeColorModel()

        viewModel.fetchServiceCall { result in
            switch result {
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default:
                exp.fulfill()
                let filterValue = self.viewModel.filteredResults
                XCTAssertEqual(filterValue, MockData.shared.getEyeColorModel())
            }
        }
        waitForExpectations(timeout: 5)
    }

}
