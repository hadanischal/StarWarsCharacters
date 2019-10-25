//
//  EyeColorModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/13/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct EyeColorModel: Equatable {
    let eyeColor: String
    let count: Int
    let results: [PersonModel]?
}

extension EyeColorModel {
    static func == (lhs: EyeColorModel, rhs: EyeColorModel) -> Bool {
        return lhs.eyeColor == rhs.eyeColor
            && lhs.count == rhs.count
            && lhs.results == rhs.results
    }
}
