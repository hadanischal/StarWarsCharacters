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

    private let endpoint = APIManager.allPersonsURL
    var task: URLSessionTask?
    private var networking: NetworkingDataSource!

    init(withNetworking networking: NetworkingDataSource = NetworkService()) {
        self.networking = networking
    }

    func fetchConverter(_ completion: @escaping ((Result<CharactersModel, ErrorResult>) -> Void)) {
        self.cancelFetchService()
        print(endpoint.absoluteString)
        task = self.networking.loadData(url: endpoint, completion: self.networkResult(completion: completion))
    }

    func cancelFetchService() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
