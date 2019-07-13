//
//  CharactersRouter.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol CharactersRouterProtocol: class {
    func fetchConverter(_ completion: @escaping ((Result<CharactersModel, ErrorResult>) -> Void))
}

final class CharactersRouter: NetworkHandler, CharactersRouterProtocol {
    static let shared = CharactersRouter()
    let endpoint = APIManager.allPersonsURL
    var task: URLSessionTask?

    func fetchConverter(_ completion: @escaping ((Result<CharactersModel, ErrorResult>) -> Void)) {
        self.cancelFetchService()
        print(endpoint.absoluteString)
        task = NetworkService().loadData(url: endpoint, completion: self.networkResult(completion: completion))
    }

    func cancelFetchService() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
