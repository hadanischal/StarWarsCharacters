//
//  EyeColorModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/13/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct EyeColorModel {
    let eyeColorArray: [String]
    let filteredResults: [String: [PersonModel]]
}

extension EyeColorModel {
    static func parseEyeColorArray(results: [PersonModel]) -> EyeColorModel {
        var filteredResults = [String: [PersonModel]]()
        let mapEyeColor = results.map { $0.eyeColor } as! [String]
        var eyeColorArray = mapEyeColor.removingDuplicates()
        for eyeColor in eyeColorArray {
            let foundItems = results.filter { $0.eyeColor == eyeColor }
            filteredResults[eyeColor] = foundItems
        }
        eyeColorArray.insert("all", at: 0)
        filteredResults["all"] = results
        let conversion = EyeColorModel(eyeColorArray: eyeColorArray, filteredResults: filteredResults)
        return conversion
    }
}
