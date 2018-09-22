//
//  Episode.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 20/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import Foundation

final class Episode {
    // MARK: - Properties
    let title: String
    let number: Int
    let airDate: Date    
    let excerpt: String
    
    private let _dateFormatter = DateFormatter()
    weak var season: Season?
    
    
    // MARK: - Initialization
    init(title: String, number: Int, excerpt: String, date: Date, season: Season?) {
        self.title = title
        self.number = number
        self.excerpt = excerpt
        self.airDate = date
        self.season = season
        self._dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let s = season {
            s.add(episode: self)
        }
    }
}

extension Episode {
    var airDateToString: String {
        return _dateFormatter.string(from: airDate)
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(season!.name) - Episodio \(number): - \(title) \(excerpt)"
    }
    
    var proxyForComparison: Date {
        return airDate
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        let firstSentence = excerpt.prefix(upTo: excerpt.index(of: ".") ?? excerpt.endIndex)
        return "\(season!.name) - Episodio \(number): - \(title) \(firstSentence)..."
    }
}

extension Episode: Equatable {
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Comparable {
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        // Orden alfabético
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension Episode {
    var fullName: String {
        return "\(season!.name) - Episodio \(number): \(title)";
    }
}
