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
    var dataSource: PersonDataSource!

    override func setUp() {
        super.setUp()
        dataSource = PersonDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {
        dataSource.data.value = []  // giving empty data value
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }

    func testValueInDataSource() {
        if let results = MockData().getPersonModel() {
            let responseResults: [PersonModel] = results
            let newArray = Array(responseResults[0..<2])
            dataSource.data.value = newArray
            let tableView = UITableView()
            tableView.dataSource = dataSource
            XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
            XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
        } else {
            XCTAssert(false, "Can't get data from FileManager")
        }
    }
}
