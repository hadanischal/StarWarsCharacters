//
//  Network.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/8/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import Alamofire

protocol Networking {
    func request(method: NetworkMethod, url: String, parameters: [String : Any]?) -> Observable<Any>
    func image(url: String) -> Observable<UIImage>
}

final class Network: Networking {
    private let queue = DispatchQueue(label: "RxGithub.Network.Queue")
    
    func request(method: NetworkMethod, url: String, parameters: [String : Any]?) -> Observable<Any> {
        return Observable.create { observer in
            let method = method.httpMethod()
            
            let request = Alamofire.request(url, method: method, parameters: parameters)
                .validate()
                .responseJSON(queue: self.queue) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(NetworkError(error: error))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func image(url: String) -> Observable<UIImage> {
        return Observable.create { observer in
            let request = Alamofire.request(url, method: .get)
                .validate()
                .response(queue: self.queue, responseSerializer: Alamofire.DataRequest.dataResponseSerializer()) { response in
                    switch response.result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            observer.onError(NetworkError.IncorrectDataReturned)
                            return
                        }
                        observer.onNext(image)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
