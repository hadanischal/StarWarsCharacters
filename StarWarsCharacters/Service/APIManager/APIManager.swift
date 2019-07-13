//
//  APIManager.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

enum Method: String {
    case allPersons = "people/"
    case allFilms = "films/"
    case allPlanets = "planets/"
    case allSpecies = "species/"
    case allStarships = "starships/"
    case allVehicles = "vehicles/"
}

struct APIManager {
    private static let baseURLString = "https://swapi.co/api/"

    static var allFilmsURL: URL {
        return SWAPIURL(method: .allFilms)
    }

    static var allPersonsURL: URL {
        return SWAPIURL(method: .allPersons)
    }

    static var allPlanetsURL: URL {
        return SWAPIURL(method: .allPlanets)
    }

    static var allSpeciesURL: URL {
        return SWAPIURL(method: .allSpecies)
    }

    static var allStarshipsURL: URL {
        return SWAPIURL(method: .allStarships)
    }

    static var allVehiclesURL: URL {
        return SWAPIURL(method: .allVehicles)
    }

    // MARK: - General Methods
    private static func SWAPIURL(method: Method) -> URL {
        let baseURL = URL(string: baseURLString)!
        let finalURL = URL(string: method.rawValue, relativeTo: baseURL)!
        return finalURL
    }
}
