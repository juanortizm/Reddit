//
//  RedditEntryDto.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

struct RedditEntryDto: Decodable {
    let storageKey = String(describing: RedditEntryDto.self)
    var id: String
    var author: String
    var title: String
    var createdUtc: Date
    var thumbnail: String?
    var numComments: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, author, title, createdUtc = "created_utc", thumbnail, numComments = "num_comments"
    }
    
    func buildComments() -> String {
        return "\(self.numComments) \(self.numComments > 1 ? "comments" : "comment")"
    }
}

extension RedditEntryDto {
    func wasSeen() -> Bool {
        return UserDefaults.standard.bool(forKey: "\(storageKey)-\(self.id)")
    }
    
    func setSeen() {
        UserDefaults.standard.set(true, forKey: "\(storageKey)-\(self.id)")
    }
}

