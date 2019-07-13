//
//  MockData.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 7/13/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import XCTest
@testable import StarWarsCharacters

class MockData {
    func getCharactersModel() -> CharactersModel? {
        var info: CharactersModel?
        guard let data = self.readJson(forResource: "Person") else {
            XCTAssert(false, "Can't get data from Person.json")
            return nil
        }
        let completion: ((Result<CharactersModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid CharactersModel")
            case .success(let converter):
                print(converter)
                info =  converter
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
        return info
    }
    func getPersonModel() -> [PersonModel]? {
        let charactersModel = getCharactersModel()
        return charactersModel?.results
    }
}

extension MockData {
    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch (_) {
            XCTFail("unable to read json")
            return nil
        }
    }
}
