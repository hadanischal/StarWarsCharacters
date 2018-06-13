//
//  PersonModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct PersonModel{
    let name: String?
    let eyeColor: String?
    let birthYear: String?
    let gender: String?
    let homeworld : String?
    let films: [String]?
    let urlString: String?
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? "unknown"
        self.eyeColor = dictionary["eye_color"] as? String
        self.birthYear = dictionary["birth_year"] as? String ?? "unknown"
        self.gender = dictionary["gender"] as? String ?? "unknown"
        self.homeworld = dictionary["homeworld"] as? String ?? "unknown"
        self.films = dictionary["films"] as? [String] ?? []
        self.urlString = dictionary["url"] as?  String ?? "unknown"
    }
}

