//
//  Character.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 6/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

final class Person  {
    // MARK: - Properties
    let name: String
    let house: House
    let photo: UIImage
    private let _alias: String?
    
    var alias: String {
        get {
            return _alias ?? ""
        }
    }
    
    // MARK: - Initialization
    init(name: String, alias: String? = nil, house: House, photo: UIImage) {
        self.name = name
        self._alias = alias
        self.house = house
        self.photo = photo
        
        house.add(person: self)
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    var proxyForComparison: String {
        return fullName.uppercased()
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        // Orden alfabético
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
