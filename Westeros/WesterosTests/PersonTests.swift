//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Manuel Sagra de Diego on 6/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {

    var starkHouse: House!
    var starkSigil: Sigil!
    var ned: Person!
    var arya: Person!
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = Repository.local.house(named: "Stark")
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterExistence() {
        XCTAssertNotNil(ned)
        XCTAssertNotNil(arya)
    }
    
    func testPersonFullName() {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
        XCTAssertEqual(arya.fullName, "Arya Stark")
    }
    
    func testPersonEquality() {
        // Identidad
        XCTAssertEqual(ned, ned)
        
        // Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(ned, eddard)
        
        // Desigualdad
        XCTAssertNotEqual(ned, arya)
    }
    
    func testPersonComparison() {
        XCTAssertLessThan(arya, ned)
    }
}
