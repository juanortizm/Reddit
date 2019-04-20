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
    
    func testDateTimeAgo() {
        let calendar = Calendar.current
        let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: Date())!
        let oneHourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let twoHoursAgo = calendar.date(byAdding: .hour, value: -2, to: Date())!
        let oneMinuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let tenMinutesAgo = calendar.date(byAdding: .minute, value: -10, to: Date())!
        let threeSecondsAgo = calendar.date(byAdding: .second, value: -3, to: Date())!
        
        XCTAssertEqual(oneDayAgo.timeAgo(), "1 day ago")
        XCTAssertEqual(twoDaysAgo.timeAgo(), "2 days ago")
        XCTAssertEqual(oneHourAgo.timeAgo(), "1 hour ago")
        XCTAssertEqual(twoHoursAgo.timeAgo(), "2 hours ago")
        XCTAssertEqual(tenMinutesAgo.timeAgo(), "10 minutes ago")
        XCTAssertEqual(oneMinuteAgo.timeAgo(), "1 minute ago")
        XCTAssertEqual(threeSecondsAgo.timeAgo(), "just now")
    }
}
