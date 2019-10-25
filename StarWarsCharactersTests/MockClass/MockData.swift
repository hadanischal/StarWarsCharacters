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
    static let shared = MockData()

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
            }
        }
        ParserHelper.parse(data: data, completion: completion)
        return info
    }
    func getPersonModel() -> [PersonModel]? {
        let charactersModel = getCharactersModel()
        return charactersModel?.results
    }

    func getEyeColorModel() -> [EyeColorModel]? {
        guard let personModel = self.getPersonModel() else { return nil}
        let value = Dictionary(grouping: personModel) { (element: PersonModel) in
            return element.eyeColor
        }
        let sorted = value.sorted {$0.key < $1.key}
        return sorted.map { EyeColorModel(eyeColor: $0.key, count: $0.value.count, results: $0.value)}
    }

    func getEyeColorModelWithAll() -> [EyeColorModel]? {
        guard let personModel = self.getPersonModel() else { return nil}
        var value = Dictionary(grouping: personModel) { (element: PersonModel) in
            return element.eyeColor
        }
        value.updateValue(personModel, forKey: "All")
        let sorted = value.sorted {$0.key < $1.key}
        return sorted.map { EyeColorModel(eyeColor: $0.key, count: $0.value.count, results: $0.value)}
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
