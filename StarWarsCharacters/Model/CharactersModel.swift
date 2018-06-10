//
//  CharactersModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct CharactersModel {
    let next: String?
   // let previous: String?
    let count: Int?
    let results: [PersonModel]
}

extension CharactersModel : Parceable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<CharactersModel, ErrorResult> {
        print(dictionary)
        if let next = dictionary["next"] as? String,
            //let previous = dictionary["previous"] as? String,
            let count = dictionary["count"] as? Int,
            let personsArray = dictionary["results"] as? [AnyObject]{
            var responseResults = [PersonModel]()
            for personJSON in personsArray {
                let currentData = PersonModel(dictionary: personJSON as! [String:Any])
                responseResults.append(currentData)
            }
            let conversion = CharactersModel(next: next, count: count, results: responseResults)
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
