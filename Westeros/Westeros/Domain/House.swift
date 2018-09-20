//
//  House.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 6/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    // MARK: - Properties
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiUrl: URL
    private var _members: Members
    
    // MARK: - Initialization
    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiUrl = url
        self._members = Members()
    }
}

extension House {
    var proxyForEquality: String {
        return "\(name) \(sigil) \(words)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        // Orden alfabético
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        if (person.house == self) {
            _members.insert(person)
        }
    }
    
    func add(persons: Person...) {
        persons.forEach { add(person: $0) }
    }
}
