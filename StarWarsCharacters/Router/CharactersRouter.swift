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
    let endpoint = APIManager.allPersonsURL
    var task : URLSessionTask?
    
    func fetchConverter(_ completion: @escaping ((Result<CharactersModel, ErrorResult>) -> Void)) {
        self.cancelFetchCurrencies()
        task = NetworkService().loadData(url: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}


