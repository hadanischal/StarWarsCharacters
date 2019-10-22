//
//  PersonViewModel.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol PersonViewModelProtocol {
    var onErrorHandling: ((ErrorResult?) -> Void)? { get set }
    func didSelectSegment(_ segmentIndex: Int)
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)?)
    var onFilteredResults: ((EyeColorModel?) -> Void)? { get set }
}

final class PersonViewModel: PersonViewModelProtocol {
    // MARK: - Input
    weak var dataSource: GenericDataSource<PersonModel>?
    var filteredResults: EyeColorModel

    // MARK: - Output
    weak var service: CharactersRouterProtocol?
    var onErrorHandling: ((ErrorResult?) -> Void)?
    var onFilteredResults: ((EyeColorModel?) -> Void)?

    init(service: CharactersRouterProtocol? = CharactersRouter.shared, dataSource: GenericDataSource<PersonModel>?) {
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
                    if let results = converter.results {
                        self.dataSource?.data.value = results
                        self.filteredResults = EyeColorModel.parseEyeColorArray(results: results)
                        self.onFilteredResults?(self.filteredResults)
                        completion?(Result.success(true))
                    } else {
                        self.onErrorHandling?(ErrorResult.parser(string: "unable to parse"))
                        completion?(Result.failure(ErrorResult.parser(string: "unable to parse")))
                    }
                case .failure(let error) :
                    self.onErrorHandling?(error)
                    completion?(Result.failure(error))
                }
            }
        }
    }

    func didSelectSegment(_ segmentIndex: Int) {
        let eyeColorArray: [String] = self.filteredResults.eyeColorArray
        let filteredResults: [String: [PersonModel]] = self.filteredResults.filteredResults
        let eyeColor = eyeColorArray[segmentIndex]
        self.dataSource?.data.value = filteredResults[eyeColor]!
    }
}
