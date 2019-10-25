//
//  PersonViewController.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

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
