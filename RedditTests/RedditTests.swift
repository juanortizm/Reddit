//
//  RedditTests.swift
//  RedditTests
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import XCTest
@testable import Reddit

class RedditTests: XCTestCase {

    func testParser() {
        guard let url = Bundle(for: RedditTests.self).url(forResource: "top", withExtension: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let model = try decoder.decode(RedditEntriesDto.self, from: data)
            let firstEntry: RedditEntryDto? = model.data.children.first?.data
            XCTAssertEqual(model.data.children.count, 25)
            XCTAssertEqual(firstEntry?.id, "2hqlxp")
            XCTAssertEqual(firstEntry?.author, "washedupwornout")
            XCTAssertEqual(firstEntry?.thumbnail, "http://b.thumbs.redditmedia.com/9N1f7UGKM5fPZydrsgbb4_SUyyLW7A27um1VOygY3LM.jpg")
            XCTAssertEqual(firstEntry?.numComments, 958)
        } catch {
            XCTFail()
        }
    }
}
