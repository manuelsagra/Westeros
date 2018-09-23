//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Manuel Sagra de Diego on 20/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var season1: Season!
    
    var episode11: Episode!
    var episode12: Episode!
    
    var dateFormatter: DateFormatter!
    
    override func setUp() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        season1 = Season(name: "Temporada 1", date: dateFormatter.date(from: "2011-04-17")!, excerpt: "Resumen")
        
        episode11 = Episode(title: "Se acerca el invierno", number: 1, excerpt: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard \"Ned\" Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.", date: dateFormatter.date(from: "2011-04-17")!, season: season1)
        
        episode12 = Episode(title: "El Camino Real", number: 2, excerpt: "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya, mientras que el hijo mayor, Robb, se queda al frente de los asuntos de su padre en la ciudad. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo.", date: dateFormatter.date(from: "2011-04-24")!, season: season1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func tesEpisodeExistence() {
        XCTAssertNotNil(episode11)
        XCTAssertNotNil(episode12)
    }
    
    func tesEpisodeHasSeason() {
        XCTAssertNotNil(episode11.season)
        XCTAssertNotNil(episode12.season)
    }
    
    func testEpisodeFullName() {
        XCTAssertEqual(episode11.fullName, "Temporada 1 - Episodio 1: Se acerca el invierno")
        XCTAssertEqual(episode12.fullName, "Temporada 1 - Episodio 2: El Camino Real")
    }
    
    func testEpisodeCustomStringConvertible() {
        XCTAssertNotNil(episode11.description)
        XCTAssertNotNil(episode12.description)
        NSLog(episode11.description)
    }
    
    func testEpisodeEquality() {
        // Identidad
        XCTAssertEqual(episode11, episode11)
        
        // Igualdad
        let episode11b = Episode(title: "Se acerca el invierno", number: 1, excerpt: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard \"Ned\" Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.", date: dateFormatter.date(from: "2011-04-17")!, season: season1)
        XCTAssertEqual(episode11, episode11b)
        
        // Desigualdad
        XCTAssertNotEqual(episode11, episode12)
    }
    
    func testPersonComparison() {
        XCTAssertLessThan(episode11, episode12)
    }
}
