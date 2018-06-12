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
    /* let height = Int()
     let mass = Int()
     let hairColor: String?
     let skinColor: String?*/
    let eyeColor: String?
    let birthYear: String?
    let gender: String?
    let homeworld : String?
    let films: [String]?
    /* let species: [String]?
     let vehicles: [String]?
     let starships: [String]?*/
    let urlString: String?
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? "unknown"
        /*self.height = dictionary["height"] as? Int
         self.mass = dictionary["mass"] as? Int
         self.hairColor = dictionary["hair_color"] as? String
         self.skinColor = dictionary["skin_color"] as? String*/
        self.eyeColor = dictionary["eye_color"] as? String
        self.birthYear = dictionary["birth_year"] as? String ?? "unknown"
        self.gender = dictionary["gender"] as? String ?? "unknown"
        self.homeworld = dictionary["homeworld"] as? String ?? "unknown"
        self.films = dictionary["films"] as? [String] ?? []
        /*self.species = dictionary["species"] as? [String]
         self.vehicles = dictionary["vehicles"] as? [String]
         self.starships = dictionary["starships"] as? [String]*/
        self.urlString = dictionary["url"] as?  String ?? "unknown"
    }
}

