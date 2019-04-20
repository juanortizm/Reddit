//
//  RedditDateDecorator.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import Foundation

extension Date {
    func timeAgo() -> String? {
        
        var secondsAgo = Int(Date().timeIntervalSince(self))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "just now"
        } else if secondsAgo < hour {
            let minutesAgo = secondsAgo/minute
            return "\(minutesAgo) \(minutesAgo == 1 ? "minute ago" : "minutes ago")"
        } else if secondsAgo < day {
            let hoursAgo = secondsAgo/hour
            return "\(hoursAgo) \(hoursAgo == 1 ? "hour ago" : "hours ago")"
        } else if secondsAgo < week {
            let daysAgo = secondsAgo/day
            return "\(daysAgo) \(daysAgo == 1 ? "day ago" : "days ago")"
        }
        return nil
    }
}
