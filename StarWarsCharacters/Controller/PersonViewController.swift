//
//  PersonViewController.swift
//  StarWarsCharacters
//
//  Created by Nischal Hada on 6/10/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var segmentedController: UISegmentedControl!

    fileprivate let segmentedInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 5.0, right: 10.0)
    fileprivate var activityIndicator: ActivityIndicator! = ActivityIndicator()
    private let refreshControl = UIRefreshControl()
    let dataSource = PersonDataSource()
    lazy var viewModel: PersonViewModel = {
        let viewModel = PersonViewModel(dataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupUIRefreshControl()
        self.setupViewModel()
        self.activityIndicator.start()
        self.viewModel.fetchServiceCall { _ in
            self.activityIndicator.stop()
        }
    }

    func setupUI() {
        self.title = "Star Wars characters"
        self.tableView.backgroundColor = ThemeColor.white
        self.view.backgroundColor = ThemeColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    func setupUIRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshPeopleData), for: .valueChanged)
    }

    func setupViewModel() {
        self.tableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        self.viewModel.onErrorHandling = { [weak self] error in
            DefaultWireframe().presentAlert(self!, title: "An error occured", message: "Oops, something went wrong!")
        }

        self.viewModel.onFilteredResults = { [weak self] result in
            self?.setupUISegmentedControl(result: result!)
        }
    }

    func setupUISegmentedControl(result: EyeColorModel) {
        let filteredResults: [String: [PersonModel]] = result.filteredResults
        var items = [String]()
        for eyeColor in result.eyeColorArray {
            let person = filteredResults[eyeColor]
            let value = eyeColor.capitalized + "(" + "\(person?.count ?? 0)" + ")"
            items.append(value)
        }
        segmentedController = UISegmentedControl(items: items)
        let paddingSpace = segmentedInsets.left * 2
        let availableWidth = view.frame.width - paddingSpace
        segmentedController.frame =  CGRect(x: segmentedInsets.left, y: segmentedInsets.top, width: availableWidth, height: segmentedController.frame.height)
        segmentedController.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
        segmentedController.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedController
        viewModel.didSelectSegment(0)
    }

    @IBAction func didSelectSegment(_ sender: Any) {
        let segmentIndex = segmentedController.selectedSegmentIndex
        viewModel.didSelectSegment(segmentIndex)
    }

    @objc private func refreshPeopleData(_ sender: Any) {
        self.activityIndicator.start()
        self.viewModel.fetchServiceCall { _ in
            self.activityIndicator.stop()
        }
        self.refreshControl.endRefreshing()
    }
}

// MARK: - TableViewDelegate Setup
extension PersonViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
