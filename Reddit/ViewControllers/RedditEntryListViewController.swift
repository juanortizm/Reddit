//
//  RedditEntryListViewController.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import UIKit

class RedditEntryListViewController: RedditBaseViewController {
    @IBOutlet weak var entriesTableView: UITableView!
    
    private var entriesPresenter: RedditEntriesPresenter!
    private var datasource: [RedditEntryDto] = [] {
        didSet {
            DispatchQueue.main.async {
                self.entriesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.showSpinner()
        self.entriesPresenter.fetchEntries()
    }
    
    private func setup() {
        self.setupNavigation()
        self.setupPresenter()
        self.setupTableView()
    }
    
    private func setupNavigation() {
        self.title = "Reddit Posts"
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setupPresenter() {
        self.entriesPresenter = RedditEntriesPresenter(service: RedditService(), attachedView: self)
    }
    
    private func setupTableView() {
        self.entriesTableView.dataSource = self
        self.entriesTableView.delegate = self
        self.entriesTableView.tableFooterView = UIView()
        
        let nibCell = UINib(nibName: String(describing: RedditEntryTableViewCell.self), bundle: Bundle(for: RedditEntryTableViewCell.self))
        self.entriesTableView.register(nibCell, forCellReuseIdentifier: String(describing: RedditEntryTableViewCell.self))
    }
}

extension RedditEntryListViewController: RedditEntriesViewProtocol {
    func fetchFinishWithSuccess(entries: [RedditEntryDto], isLoadMore: Bool) {
        self.hideSpinner()
        if isLoadMore {
            self.datasource += entries
        } else {
            self.datasource = entries
        }
        
    }
    
    func fetchFinishWithError(error: RedditNetworkResult.RedditNetworkError) {
        // TODO: show error detail
        self.hideSpinner()
        self.showGenericAlert()
    }
}

extension RedditEntryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = entriesTableView.dequeueReusableCell(withIdentifier: String(describing: RedditEntryTableViewCell.self), for: indexPath) as? RedditEntryTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: datasource[indexPath.row])
        
        return cell
    }
}

extension RedditEntryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.entriesTableView.deselectRow(at: indexPath, animated: true)
        self.showDetailViewController(RedditEntryDetailViewController(), sender: nil)
    }
}
