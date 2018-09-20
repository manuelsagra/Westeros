//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Manuel Sagra de Diego on 12/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {
    
    var localHouses: [House]!
    var localSeasons: [Season]!

    override func setUp() {
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }

    // MARK: - Houses
    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertGreaterThan(localHouses.count, 0)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryHousesHavePersons() {
        for house in localHouses {
            XCTAssertGreaterThan(house.count, 0)
        }
    }
    
    func testLocalRepositoryReturnsHouseByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "sTARk")
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
        let filtered = Repository.local.houses { $0.count == 1 }
        XCTAssertEqual(filtered.count, 1)
        
        let filtered2 = Repository.local.houses { $0.count == 100000 }
        XCTAssertTrue(filtered2.isEmpty)
    }
    
    // MARK: - Seasons
    func testLocalRepositorySeasonsCreation() {
        XCTAssertNotNil(localSeasons)
        XCTAssertGreaterThan(localSeasons.count, 0)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfSeasons() {
        XCTAssertEqual(localSeasons, localSeasons.sorted())
    }
    
    func testLocalRepositorySeasonsHaveEpisodes() {
        for season in localSeasons {
            XCTAssertGreaterThan(season.count, 0)
        }
    }
}
