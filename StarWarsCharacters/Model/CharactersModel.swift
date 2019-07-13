//
//  CharactersModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct CharactersModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PersonModel]?
}

extension CharactersModel: Parceable {
    static func parseObject(data: Data) -> Result<CharactersModel, ErrorResult> {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode(CharactersModel.self, from: data) {
            return Result.success(result)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse flickr results"))
        }
    }
}
