//
//  PersonViewModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class PersonViewModel {
    // MARK: - Input
    weak var dataSource : GenericDataSource<PersonModel>?
    var filteredResults:EyeColorModel
    
    // MARK: - Output
    weak var service: CharactersRouterProtocol?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var onFilteredResults : ((EyeColorModel?) -> Void)?
    
    init(service: CharactersRouterProtocol? = CharactersRouter.shared, dataSource : GenericDataSource<PersonModel>?) {
        self.dataSource = dataSource
        self.filteredResults =  EyeColorModel(eyeColorArray: [], filteredResults: [:])
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
                    self.dataSource?.data.value = converter.results
                    let results = EyeColorModel.parseEyeColorArray(results: converter.results)
                    self.filteredResults = results
                    self.onFilteredResults?(results)
                    
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
       
    func didSelectSegment(_ segmentIndex: Int) {
        let eyeColorArray: [String] = self.filteredResults.eyeColorArray
        let filteredResults: [String : [PersonModel]] = self.filteredResults.filteredResults
        let eyeColor = eyeColorArray[segmentIndex]
        self.dataSource?.data.value = filteredResults[eyeColor]!
    }
}
