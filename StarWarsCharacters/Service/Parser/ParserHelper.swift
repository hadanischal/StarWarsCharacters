//
//  ParserHelper.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    static func parse<T: Parceable>(data: Data, completion: (Result<[T], ErrorResult>) -> Void) {
        do {
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                print(result)
                var finalResult: [T] = []
                for object in result {
                    if let dictionary = object as? [String: AnyObject] {
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure:
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel)
                            break
                        }
                    }
                }
                completion(.success(finalResult))
            } else {
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }

    static func parse<T: Parceable>(data: Data, completion: (Result<T, ErrorResult>) -> Void) {
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }
            } else {
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
