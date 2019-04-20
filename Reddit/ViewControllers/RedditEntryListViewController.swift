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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFetch), for: .valueChanged)
        self.entriesTableView.refreshControl = refreshControl
    }
    
    @objc private func refreshFetch() {
        self.entriesPresenter.fetchEntries()
    }
    
    private func loadMore() {
        guard let lastEntryId = datasource.last?.id else { return }
        self.entriesPresenter.fetchEntries(lastEntryId: lastEntryId)
    }
    
    @IBAction func didTapDismissAllButton(_ sender: Any) {
        self.entriesTableView.beginUpdates()
        for index in 0..<datasource.count {
            let indexPath = IndexPath(row: index, section: 0)
            self.entriesTableView.deleteRows(at: [indexPath], with: .left)
        }
        self.datasource.removeAll()
        self.entriesTableView.endUpdates()
    }
}

extension RedditEntryListViewController: RedditEntriesViewProtocol {
    func fetchFinishWithSuccess(entries: [RedditEntryDto], isLoadMore: Bool) {
        self.hideSpinner()
        if isLoadMore {
            self.datasource += entries
        } else {
            self.datasource = entries
            DispatchQueue.main.async {
                self.entriesTableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func fetchFinishWithError(error: RedditNetworkResult.RedditNetworkError) {
        self.hideSpinner()
        self.showAlert(title: "Error Retreiving entries")
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
        
        cell.didTapDismissBlock = { cell in
            guard let indexPath = self.entriesTableView.indexPath(for: cell) else { return }
            self.entriesTableView.beginUpdates()
            self.datasource.remove(at: indexPath.row)
            self.entriesTableView.deleteRows(at: [indexPath], with: .left)
            self.entriesTableView.endUpdates()
        }
        
        return cell
    }
}

extension RedditEntryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = entriesTableView.cellForRow(at: indexPath) as? RedditEntryTableViewCell else { return }
        self.entriesTableView.deselectRow(at: indexPath, animated: true)
        self.datasource[indexPath.row].setSeen()
        cell.wasSeenIndicatorView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == datasource.count - 1 {
            loadMore()
        }
    }
}

extension RedditEntryListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard "DetailSegue" == segue.identifier,
              let indexPath = entriesTableView.indexPathForSelectedRow,
              let redditDetailViewController = (segue.destination as? UINavigationController)?.topViewController as? RedditEntryDetailViewController else {
            return
        }
        
        redditDetailViewController.model = datasource[indexPath.row]
    }
}
