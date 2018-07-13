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
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        count = json["count"] as? Int ?? 0
        next = json["next"] as? String ?? ""
        previous = json["previous"] as? String ?? ""
        results = (json["results"] as? [[String: Any]] ?? []).compactMap{PersonModel(json: $0)}
    }
}

extension CharactersModel : Parceable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<CharactersModel, ErrorResult>{
        if let _ = dictionary["results"]{
            guard let result = CharactersModel.init(json: dictionary)else{
                return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
            }
            return Result.success(result)
            
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
