//
//  PersonModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct PersonModel: Codable {
    let name: String?
    let eyeColor: String?
    let birthYear: String?
    let gender: String?
    let homeworld: String?
    let films: [String]?
    let urlString: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String?.self, forKey: .name)
        eyeColor = try container.decode(String?.self, forKey: .eyeColor)
        birthYear = try container.decode(String?.self, forKey: .birthYear)
        gender = try container.decode(String?.self, forKey: .gender)
        homeworld = try container.decode(String?.self, forKey: .homeworld)
        films = try container.decode([String]?.self, forKey: .films)
        urlString = try container.decode(String?.self, forKey: .urlString)
    }

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender = "gender"
        case homeworld = "homeworld"
        case films = "films"
        case urlString = "url"
    }

}
