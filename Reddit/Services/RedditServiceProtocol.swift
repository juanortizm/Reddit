//
//  RedditServiceProtocol.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

protocol RedditServiceProtocol {
    func fetchEntries (limit: Int?, lastEntryId: String?, completion: @escaping (RedditNetworkResult) -> Void) -> Void
}

