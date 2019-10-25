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
    var filteredResults: [EyeColorModel] { get }
}

final class PersonViewModel: PersonViewModelProtocol {
    // MARK: - Input
    private var service: CharactersRouterProtocol?
    private weak var dataSource: GenericDataSource<PersonModel>?
    private var personHelper: PersonHelperDataSource

    // MARK: - Output
    var filteredResults: [EyeColorModel] = []
    var onErrorHandling: ((ErrorResult?) -> Void)?
    var onFilteredResults: ((EyeColorModel?) -> Void)?

    init(service: CharactersRouterProtocol = CharactersRouter(),
         withPersonHelper personHelper: PersonHelperDataSource = PersonHelper(),
         dataSource: GenericDataSource<PersonModel>?) {
        self.service = service
        self.personHelper = personHelper
        self.dataSource = dataSource
    }

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        guard let service = self.service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        service.fetchConverter { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    if let results = converter.results {
                        self?.dataSource?.data.value = results
                        self?.filteredResults = self?.personHelper.parseEyeColorArray(results: results) ?? []
                        completion?(Result.success(true))
                    } else {
                        self?.onErrorHandling?(ErrorResult.parser(string: "unable to parse"))
                        completion?(Result.failure(ErrorResult.parser(string: "unable to parse")))
                    }
                case .failure(let error) :
                    self?.onErrorHandling?(error)
                    completion?(Result.failure(error))
                }
            }
        }
    }

    func didSelectSegment(_ segmentIndex: Int) {
        self.dataSource?.data.value = filteredResults[segmentIndex].results ?? []
    }
}
