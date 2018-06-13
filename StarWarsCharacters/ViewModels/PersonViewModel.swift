//
//  PersonViewModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct PersonViewModel {
    weak var dataSource : GenericDataSource<PersonModel>?
    weak var service: CharactersRouterProtocol?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: CharactersRouterProtocol? = CharactersRouter.shared, dataSource : GenericDataSource<PersonModel>?) {
        self.dataSource = dataSource
        self.service = service 
    }
    
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        service.fetchConverter { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    //print(converter)
                    self.dataSource?.data.value = converter.results
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
