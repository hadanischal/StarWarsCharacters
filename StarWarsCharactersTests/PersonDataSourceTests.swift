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
        dataSource.data.value = []  // giving empty data value
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        if getDataValue().count != 0{
            let responseResults:[PersonModel] = getDataValue()
            let newArray = Array(responseResults[0..<2])
            dataSource.data.value = newArray
            let tableView = UITableView()
            tableView.dataSource = dataSource
            XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
            XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
        }else{
            XCTAssert(false, "Can't get data from FileManager")
        }
    }
        
    func getDataValue() ->[PersonModel]{
        var responseResults = [PersonModel]()
        guard let data = FileManager.readJson(forResource: "Person") else {
            XCTAssert(false, "Can't get data from Person.json")
            return responseResults
        }
        let completion : ((Result<CharactersModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid converter")
            case .success(let converter):
                print(converter)
                responseResults = converter.results
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
        return responseResults
    }
}

extension FileManager {
    static func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: PersonDataSourceTests.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
            }
        }
        return nil
    }
}
