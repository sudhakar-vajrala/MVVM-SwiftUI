//
//  Video.swift
//  VideoPlayer
//
//  Created by Venkata Sudhakar Reddy on 12/04/25.
//

import Foundation

struct Video: Identifiable {
    var id: Int { sessionID }
    
    let sessionID: Int
    let title: String
    let duration: Int
    let weekDay: WeekDays
    let platforms: [Platform]
    let urlString: String
    var isFavorite = false
}

extension Video: Equatable {
    static func == (lhs: Video, rhs: Video) -> Bool {
        lhs.sessionID == rhs.sessionID
    }
}

extension Video {
    var url: URL? {
        URL(string: urlString)
    }
}
