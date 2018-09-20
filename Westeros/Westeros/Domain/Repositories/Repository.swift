//
//  Repository.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 12/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

typealias HouseToBool = (House) -> Bool
protocol HouseFactory {
    var houses: [House] { get }
    
    func house(named: String) -> House?
    
    func houses(filteredBy: HouseToBool) -> [House]
}

final class LocalFactory: HouseFactory {
    var houses: [House] {
        // Sigils
        let starkSigil = Sigil(image: UIImage(named: "stark")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "León Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryen.jpg")!, description: "Un dragón tricéfalo")
        
        // Houses
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        // Characters
        _ = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        _ = Person(name: "Arya", house: starkHouse)
        _ = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        _ = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        _ = Person(name: "Cersei", house: lannisterHouse)
        _ = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        _ = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        return [
            starkHouse,
            lannisterHouse,
            targaryenHouse
        ].sorted()
    }
    
    func house(named: String) -> House? {
        //return houses.filter { $0.name.lowercased() == named.lowercased() }.first
        return houses.first { $0.name.lowercased() == named.lowercased() }
    }
    
    func houses(filteredBy: HouseToBool) -> [House] {
        return houses.filter(filteredBy)
    }
}
