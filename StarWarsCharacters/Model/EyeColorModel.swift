//
//  EyeColorModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/13/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct EyeColorModel {
    let eyeColor: String
    let count: Int
    let results: [PersonModel]?
}

extension EyeColorModel {
    static func parseEyeColorArray(results: [PersonModel]) -> [EyeColorModel] {
        var value = Dictionary(grouping: results) { (element: PersonModel) in
            return element.eyeColor
        }
        value.updateValue(results, forKey: "All")
        let sorted = value.sorted {$0.key < $1.key}

        return sorted.compactMap { return EyeColorModel(eyeColor: $0.key, count: $0.value.count, results: $0.value)}
    }
}
