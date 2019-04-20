//
//  RedditEntryDto.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

struct RedditEntryDto: Decodable {
    var id: String
    var author: String
    var title: String
    var createdUtc: Date
    var thumbnail: String?
    var numComments: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, author, title, createdUtc = "created_utc", thumbnail, numComments = "num_comments"
    }
}

