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
        self.service.fetchEntries(limit: limit, lastEntryId: lastEntryId) { result in
            switch result {
            case .success(let entries):
                self.attachedView.fetchFinishWithSuccess(entries: entries, isLoadMore: lastEntryId != nil)
            case .failure(let error):
                self.attachedView.fetchFinishWithError(error: error)
            }
        }
    }
}
