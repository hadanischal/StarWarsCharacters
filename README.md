# StarWarsCharacters

## Requirements:
* iOS 11.0+
* Xcode 10.2.1
* Swift 5.0

## Compatibility
This demo is expected to be run using Swift 5.0 and Xcode 10.2.x.

## Objective:
This is a simple Demo project which aims to demonstate the  Star Wars Characters using MVVM pattern in Swift.
* This project was intended to work as a Star Wars Characters demo projects for iOS using Swift. It has been structured using the MVVM design pattern.
* The demo uses the [Star Wars API](http://swapi.co) as an excuse to have a nice use-case, because querying a WebService API is asynchronous by nature and is thus a good example for showing how It can be useful .

## Specification
*  Please build an IPhone app that uses the free [Star Wars API](http://swapi.co) 

## Guidelines
*  Shows a list view of all Star Wars characters (people) with their names and eye-color.
*  Add a dynamic control (for example segment control) that filters the list by eye-color of people. This segment control should be scalable for the future, so should automatically show more elements when the api returns more eye-colors some day. Each segment should show the eye color and the amount of people, like:" green (12) "

 ## App Demo

 ![](/ScreenShots/StarWarsCharacters.gif "")

### Model
These hold the app data. These are the structs and classes that you have created to hold the data you receive from a REST API or from some other data source.
* CharactersModel.swift
```swift
struct CharactersModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PersonModel]?
}

extension CharactersModel: Parceable {
    static func parseObject(data: Data) -> Result<CharactersModel, ErrorResult> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let result = try? decoder.decode(CharactersModel.self, from: data) {
            return Result.success(result)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse flickr results"))
        }
    }
}
```
* PersonModel.swift
```swift
struct PersonModel: Codable, Equatable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear: String
    let gender: Gender
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String
}
```
* Gender.swift
```swift
enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case notAvailable = "n/a"
}
```

* EyeColorModel.swift 
```swift
struct EyeColorModel: Equatable {
    let eyeColor: String
    let count: Int
    let results: [PersonModel]?
}

extension EyeColorModel {
    static func == (lhs: EyeColorModel, rhs: EyeColorModel) -> Bool {
        return lhs.eyeColor == rhs.eyeColor
            && lhs.count == rhs.count
            && lhs.results == rhs.results
    }
}
```


### ViewModel
To be able to bind values from our ViewModel to our View, we need element with an observable pattern. In iOS, we could use `KVO` pattern to add and remove observers, but I would prefer `RxSwift`. KVO observing, async operations and streams are all unified under abstraction of sequence. This is the reason why Rx is so simple, elegant and powerful.

* PersonViewModelProtocol
```swift

protocol PersonViewModelProtocol {
    var onErrorHandling: ((ErrorResult?) -> Void)? { get set }
    func didSelectSegment(_ segmentIndex: Int)
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)?)
    var filteredResults: [EyeColorModel] { get }
}
```

* PersonViewModel.swift
```swift

import Foundation

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

```

* PersonDataSource.swift
```swift
import Foundation
import UIKit

class GenericDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

final class PersonDataSource: GenericDataSource<PersonModel>, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PeopleTableViewCell
        let data = self.data.value[indexPath.row]
        cell.personModel = data
        return cell
    }

}
```

### View
let’s implement our View, which is EmployeeRosterVC. What’s need to be done there is to link a UITableView to its dataSource, but also to bind values to be able to automatically refresh the UI when new data is available

```swift
import UIKit
import Segmentio

class PersonViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentioView: Segmentio!

    fileprivate var activityIndicator: ActivityIndicator! = ActivityIndicator()
    private let refreshControl = UIRefreshControl()
    let dataSource = PersonDataSource()
    lazy var viewModel: PersonViewModelProtocol = {
        let viewModel = PersonViewModel(dataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        setupUIRefreshControl()
        setupViewModel()
        activityIndicator.start()
    }

    private func setupUI() {
        title = "Star Wars characters"
        tableView.backgroundColor = .white
        view.backgroundColor = .white
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        segmentioView.isHidden = true
    }

    private func setupUIRefreshControl() {
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshPeopleData), for: .valueChanged)
    }

    private func setupViewModel() {
        tableView.dataSource = self.dataSource

        dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        viewModel.onErrorHandling = { [weak self] error in
            self?.activityIndicator.stop()
            DefaultWireframe().presentAlert(self!, title: "An error occured", message: "Oops, something went wrong!")
        }

        viewModel.fetchServiceCall { [weak self] _ in
            self?.activityIndicator.stop()
            self?.setupSegmentioView()
        }
    }

    @objc private func refreshPeopleData(_ sender: Any) {
        activityIndicator.start()
        viewModel.fetchServiceCall { _ in
            self.activityIndicator.stop()
        }
        refreshControl.endRefreshing()
    }
}

extension PersonViewController {
    private func setupSegmentioView() {
        segmentioView.isHidden = false

        let segmentioContent = viewModel.filteredResults.flatMap { result -> [SegmentioItem] in
            return [SegmentioItem(title: result.eyeColor.capitalized, image: nil)]
        }
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: .onlyLabel,
            segmentioContent: segmentioContent
        )

        viewModel.filteredResults.enumerated().forEach { result in
            SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: result.offset, count: result.element.count)
        }

        segmentioView.selectedSegmentioIndex = 0

        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            print("Selected item: \(segmentIndex)")
            self?.viewModel.didSelectSegment(segmentIndex)
        }
    }

}

// MARK: - TableView Setup

fileprivate extension PersonViewController {

    func configureTableView() {
        tableView.register(PeopleTableViewCell.self)
        tableView.estimatedRowHeight = 83
        tableView.rowHeight = UITableView.automaticDimension
    }
}


```