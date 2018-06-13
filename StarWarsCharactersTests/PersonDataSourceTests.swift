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
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.data.value = []
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected zero cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
}
