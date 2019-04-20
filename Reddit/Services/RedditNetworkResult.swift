//
//  RedditNetworkResult.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

enum RedditNetworkResult {
    case success(entries: [RedditEntryDto])
    case failure(with: RedditNetworkError)
    
    enum RedditNetworkError {
        case notFound
        case serverError(error: Error)
        case parserError
        case defaultError
    }
}
