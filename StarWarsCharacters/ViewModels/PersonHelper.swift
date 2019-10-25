//
//  PersonHelper.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 25/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol PersonHelperDataSource {
    func parseEyeColorArray(results: [PersonModel]) -> [EyeColorModel]
}

final class PersonHelper: PersonHelperDataSource {
    func parseEyeColorArray(results: [PersonModel]) -> [EyeColorModel] {
        var value = Dictionary(grouping: results) { (element: PersonModel) in
            return element.eyeColor
        }
        value.updateValue(results, forKey: "All")
        let sorted = value.sorted {$0.key < $1.key}
        return sorted.compactMap { return EyeColorModel(eyeColor: $0.key, count: $0.value.count, results: $0.value)}
    }
}
