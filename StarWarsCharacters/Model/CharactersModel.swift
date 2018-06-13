//
//  CharactersModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct CharactersModel {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PersonModel]
    
//    let eyeColorArray: [String]
//    let filteredResults: [String : [PersonModel]]

}

extension CharactersModel : Parceable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<CharactersModel, ErrorResult> {
        print(dictionary)
        if let next = dictionary["next"] as? String,
            let previous = dictionary["previous"] as? String,
            let count = dictionary["count"] as? Int,
            let personsArray = dictionary["results"] as? [AnyObject]{
            var responseResults = [PersonModel]()
            for personJSON in personsArray {
                let currentData = PersonModel(dictionary: personJSON as! [String:Any])
                responseResults.append(currentData)
            }
            /*
            var filteredResults = [String : [PersonModel]]()
            let eye_color = responseResults.map { $0.eyeColor }
            let myArray:[String] = eye_color as! [String]
            let eyeColorArray = myArray.removingDuplicates()
            for eyeColor in eyeColorArray {
                let foundItems = responseResults.filter { $0.eyeColor == eyeColor }
                filteredResults[eyeColor] = foundItems
            }
            */
            let conversion = CharactersModel(count: count, next: next, previous: previous, results: responseResults)
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}


/*
 print(responseResults)
 //            let foundItems = responseResults.filter { $0.gender == "male" }
 //            print(foundItems)
 
 */
