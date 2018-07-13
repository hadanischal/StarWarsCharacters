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
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        self.name = json["name"] as? String ?? "unknown"
        self.eyeColor = json["eye_color"] as? String ?? ""
        self.birthYear = json["birth_year"] as? String ?? "unknown"
        self.gender = json["gender"] as? String ?? "unknown"
        self.homeworld = json["homeworld"] as? String ?? "unknown"
        self.films = json["films"] as? [String] ?? []
        self.urlString = json["url"] as?  String ?? "unknown"
    }
}
