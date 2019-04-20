//
//  RedditEntriesPresenter.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

class RedditEntriesPresenter {
    private var service: RedditServiceProtocol
    private var attachedView: RedditEntriesViewProtocol
    
    init(service: RedditServiceProtocol, attachedView: RedditEntriesViewProtocol) {
        self.service = service
        self.attachedView = attachedView
    }
    
    internal func fetchEntries(limit: Int? = 50, lastEntryId: String? = nil) {
        self.service.fetchEntries(limit: limit, lastEntryId: lastEntryId) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let entries):
                strongSelf.attachedView.fetchFinishWithSuccess(entries: entries, isLoadMore: lastEntryId != nil)
            case .failure(let error):
                strongSelf.attachedView.fetchFinishWithError(error: error)
            }
        }
    }
}
