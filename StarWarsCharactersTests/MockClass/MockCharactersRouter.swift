//
//  MockCharactersRouter.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 7/13/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import StarWarsCharacters

class MockCharactersRouter: CharactersRouterProtocol {
    var charactersData: CharactersModel?
    func fetchConverter(_ completion: @escaping ((Result<CharactersModel, ErrorResult>) -> Void)) {
        if let data = charactersData {
            completion(Result.success(data))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
}
