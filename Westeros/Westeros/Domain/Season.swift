//
//  Season.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 20/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>
final class Season {
    let name: String
    let launchDate: Date
    let excerpt: String
    
    private let _dateFormatter = DateFormatter()
    private var _episodes: Episodes
    
    init(name: String, date: Date, excerpt: String) {
        self.name = name
        self.launchDate = date
        self.excerpt = excerpt
        self._episodes = Episodes()
        self._dateFormatter.dateFormat = "yyyy-MM-dd"
    }
}

extension Season {
    var launchDateToString: String {
        return _dateFormatter.string(from: launchDate)
    }
}

extension Season {
    var proxyForEquality: String {
        return "\(name) \(launchDateToString) \(excerpt) \(count)"
    }
    var proxyForComparison: Date {
        return launchDate
    }
}

extension Season: CustomStringConvertible {
    var description: String {
        return "\(name) (\(launchDateToString)) - \(count) Episodios"
    }
}

extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        if (episode.season == self) {
            _episodes.insert(episode)
        }
    }
}
