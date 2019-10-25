//
//  MockPersonHelper.swift
//  StarWarsCharactersTests
//
//  Created by Nischal Hada on 26/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import StarWarsCharacters

class MockPersonHelper: PersonHelperDataSource {
    var eyeColorData: [EyeColorModel]?

    func parseEyeColorArray(results: [PersonModel]) -> [EyeColorModel] {
        if let data = eyeColorData {
            return data
        } else {
            return []
        }
    }
}
