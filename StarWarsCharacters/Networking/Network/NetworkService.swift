//
//  NetworkService.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/9/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol NetworkingDataSource: class {
    func loadData(url: URL, completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask?
}

final class NetworkService: NetworkingDataSource {
    private var session: URLSession!

    init(_ session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func loadData(url: URL, completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        var request = NetworkMethod.request(method: .GET, url: url)
        if let reachability =  try? Reachability(),
        reachability.connection == .unavailable {
            request.cachePolicy = .returnCacheDataDontLoad
        }
        let task = self.session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
