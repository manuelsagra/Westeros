//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Manuel Sagra de Diego on 20/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {

    var season1: Season!
    var season2: Season!
    
    var episode12: Episode!
    var episode21: Episode!
    
    var dateFormatter: DateFormatter!
    
    override func setUp() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        season1 = Season(name: "Temporada 1", date: dateFormatter.date(from: "2011-04-17")!)
        season2 = Season(name: "Temporada 2", date: dateFormatter.date(from: "2012-04-01")!)
        
        episode12 = Episode(title: "El Camino Real", number: 2, excerpt: "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya, mientras que el hijo mayor, Robb, se queda al frente de los asuntos de su padre en la ciudad. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo.", date: dateFormatter.date(from: "2011-04-24")!, season: season1)
        
        episode21 = Episode(title: "El Norte no olvida", number: 2, excerpt: "Mientras Robb Stark y su ejército del Norte continúan en guerra contra los Lannister, Tyrion llega a Desembarco del Rey para aconsejar Joffrey y moderar los excesos del joven rey. En la isla de Rocadragón, Stannis Baratheon planea de una invasión para reclamar el trono de su difunto hermano, aliándose con Melisandre, una extraña sacerdotisa que rinde culto a un dios extraño. Al otro lado del mar, Daenerys, sus tres jóvenes dragones y su khalasar caminan a través del desierto en busca de aliados, o agua. En el Norte, Bran preside Invernalia, mientras que más allá del Muro, Jon Nieve y la Guardia de la Noche deben lidiar con una salvaje.", date: dateFormatter.date(from: "2012-04-01")!, season: season2)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeasonExistence() {
        XCTAssertNotNil(season1)
        XCTAssertNotNil(season2)
    }
    
    func testSeasonHasEpisodes() {
        XCTAssertGreaterThan(season1.count, 0)
        XCTAssertGreaterThan(season2.count, 0)
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertNotNil(season1.description)
        XCTAssertNotNil(season2.description)
    }

    func testSeasonEquality() {
        XCTAssertEqual(season1, season1)
        
        let season1b = Season(name: "Temporada 1", date: dateFormatter.date(from: "2011-04-17")!)
        _ = Episode(title: "El Camino Real", number: 2, excerpt: "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya, mientras que el hijo mayor, Robb, se queda al frente de los asuntos de su padre en la ciudad. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo.", date: dateFormatter.date(from: "2011-04-24")!, season: season1b)
        XCTAssertEqual(season1, season1b)
        
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
    }
    
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
    }
    
    func testSeasonSortedEpisodesReturnsASortedArray() {
        _ = Episode(title: "Se acerca el invierno", number: 1, excerpt: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard \"Ned\" Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.", date: dateFormatter.date(from: "2011-04-17")!, season: season1)
        
        let episodes = season1.sortedEpisodes
        
        XCTAssertLessThan(episodes[0], episodes[1])
    }
}
