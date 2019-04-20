//
//  RedditEntriesViewProtocol.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

protocol RedditEntriesViewProtocol {
    func fetchFinishWithSuccess(entries: [RedditEntryDto], isLoadMore: Bool)
    func fetchFinishWithError(error: RedditNetworkResult.RedditNetworkError)
}
