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
protocol SeasonFactory {
    var seasons: [Season] { get }
}

final class LocalFactory {
    
}

extension LocalFactory: HouseFactory {
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

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Seasons
        let season1 = Season(name: "Temporada 1", date: dateFormatter.date(from: "2011-04-17")!)
        let season2 = Season(name: "Temporada 2", date: dateFormatter.date(from: "2012-04-01")!)
        let season3 = Season(name: "Temporada 3", date: dateFormatter.date(from: "2013-03-21")!)
        let season4 = Season(name: "Temporada 4", date: dateFormatter.date(from: "2014-04-06")!)
        let season5 = Season(name: "Temporada 5", date: dateFormatter.date(from: "2015-04-12")!)
        let season6 = Season(name: "Temporada 6", date: dateFormatter.date(from: "2016-04-24")!)
        let season7 = Season(name: "Temporada 7", date: dateFormatter.date(from: "2017-07-16")!)
        
        // Season 1 Episodes
        _ = Episode(title: "Se acerca el invierno", number: 1, excerpt: "El rey Robert Baratheon de Poniente viaja al Norte para ofrecerle a su viejo amigo Eddard \"Ned\" Stark, Guardián del Norte y Señor de Invernalia, el puesto de Mano del Rey. La esposa de Ned, Catelyn, recibe una carta de su hermana Lysa que implica a miembros de la familia Lannister, la familia de la reina Cersei, en el asesinato de su marido Jon Arryn, la anterior Mano del Rey. Bran, uno de los hijos de Ned y Catelyn, escala un muro y descubre a la reina Cersei y a su hermano Jaime teniendo relaciones sexuales, Jaime empuja al pequeño Bran esperando que la caída lo mate y así evitar ser delatado por el niño. Mientras tanto, al otro lado del mar Angosto, el príncipe exiliado Viserys Targaryen forja una alianza para recuperar el Trono de Hierro: dará a su hermana Daenerys en matrimonio al salvaje dothraki Khal Drogo a cambio de su ejército. El caballero exiliado Jorah Mormont se unirá a ellos para proteger a Daenerys.", date: dateFormatter.date(from: "2011-04-17")!, season: season1)
        _ = Episode(title: "El Camino Real", number: 2, excerpt: "Tras aceptar su nuevo rol como Mano del Rey, Ned parte hacia Desembarco del Rey con sus hijas Sansa y Arya, mientras que el hijo mayor, Robb, se queda al frente de los asuntos de su padre en la ciudad. Jon Nieve, el hijo bastardo de Ned, se dirige al Muro para unirse a la Guardia de la Noche. Tyrion Lannister, el hermano menor de la Reina, decide no ir con el resto de la familia real al sur y acompaña a Jon en su viaje al Muro. Viserys sigue esperando su momento de ganar el Trono de Hierro y Daenerys centra su atención en aprender cómo gustarle a su nuevo esposo, Drogo.", date: dateFormatter.date(from: "2011-04-24")!, season: season1)
        
        // Season 2 Episodes
        _ = Episode(title: "El Norte no olvida", number: 1, excerpt: "Mientras Robb Stark y su ejército del Norte continúan en guerra contra los Lannister, Tyrion llega a Desembarco del Rey para aconsejar Joffrey y moderar los excesos del joven rey. En la isla de Rocadragón, Stannis Baratheon planea de una invasión para reclamar el trono de su difunto hermano, aliándose con Melisandre, una extraña sacerdotisa que rinde culto a un dios extraño. Al otro lado del mar, Daenerys, sus tres jóvenes dragones y su khalasar caminan a través del desierto en busca de aliados, o agua. En el Norte, Bran preside Invernalia, mientras que más allá del Muro, Jon Nieve y la Guardia de la Noche deben lidiar con una salvaje.", date: dateFormatter.date(from: "2012-04-01")!, season: season2)
        _ = Episode(title: "Las tierras de la noche", number: 2, excerpt: "A raíz de una purga sangrienta en la capital, Tyrion castiga Cersei por alejar a los súbditos del Rey. En el camino hacia el norte, Arya comparte un secreto con Gendry. Por su parte, después de nueve años como prisionero de los Stark, Theon Greyjoy se reúne con su padre Balon, que quiere restaurar el antiguo reino de las Islas del Hierro. Davos convence a Salladhor Saan, un pirata, para unir fuerzas con Stannis y Melisandre de cara a una invasión naval de Desembarco del Rey.", date: dateFormatter.date(from: "2012-04-08")!, season: season2)
        
        // Season 3 Episodes
        _ = Episode(title: "Valar Dohaeris", number: 1, excerpt: "Samwell Tarly, el lord comandante Mormont y un grupo reducido de la Guardia de la Noche logran salvarse del ataque de los espectros. Jon llega al campamento de los salvajes y habla con Mance Rayder. Tyrion tiene una conversación con su padre y le hace una demanda. Margaery Tyrell comienza a cimentar su camino como futura reina. Robb y su ejército llegan a un devastado Harrenhal. Daenerys desembarca en Astapor y recibe varias sorpresas.", date: dateFormatter.date(from: "2013-03-31")!, season: season3)
        _ = Episode(title: "Alas negras, palabras negras", number: 2, excerpt: "Samwell Tarly, el lord comandante Mormont y un grupo reducido de la Guardia de la Noche logran salvarse del ataque de los espectros. Jon llega al campamento de los salvajes y habla con Mance Rayder. Tyrion tiene una conversación con su padre y le hace una demanda. Margaery Tyrell comienza a cimentar su camino como futura reina. Robb y su ejército llegan a un devastado Harrenhal. Daenerys desembarca en Astapor y recibe varias sorpresas.", date: dateFormatter.date(from: "2013-04-07")!, season: season3)
        
        // Season 4 Episodes
        _ = Episode(title: "Dos espadas", number: 1, excerpt: "Tywin Lannister regala a su hijo Jaime, nuevo comandante de la Guardia Real, una espada de acero valyrio. Tyrion y Bronn reciben al díscolo príncipe Oberyn Martell, que busca venganza por las afrentas pasadas a su casa. Sansa, mientras tanto, recibe un regalo inesperado de Dontos Hollard. En el norte, Ygritte y Tormund se reúnen con nuevos refuerzos. En el Castillo Negro, Jon Nieve es sometido a juicio por su tiempo entre los salvajes. En su camino a Meereen, Daenerys descubre que no será bien recibida. En las Tierras de los Ríos, el Perro y Arya Stark tienen un encontronazo con soldados Lannister en una taberna.", date: dateFormatter.date(from: "2014-04-06")!, season: season4)
        _ = Episode(title: "El león y la rosa", number: 2, excerpt: "Ramsay Nieve recibe a su padre lord Roose Bolton en Fuerte Terror. Al norte del Muro, Bran emplea sus habilidades como cambiapieles. En Rocadragón, Melisandre ordena quemar vivos en una hoguera a varios hombres de Stannis Baratheon. Desembarco del Rey celebra la boda del rey Joffrey Baratheon con Margaery Tyrell, pero Joffrey es envenenado durante esta y muere. ", date: dateFormatter.date(from: "2014-04-13")!, season: season4)
        
        // Season 5 Episodes
        _ = Episode(title: "Las guerras venideras", number: 1, excerpt: "En un flashback se muestra a Cersei de niña preguntándole a una adivina por su futuro. En Desembarco del Rey Cersei critica a Jaime por liberar a Tyrion y provocar indirectamente la muerte de su padre. Mientras, en Pentos, Varys lleva a salvo a Tyrion y le revela su trabajo secreto junto con Illyrio Mopatis para llevar a Daenerys al trono de hierro. Varys invita a Tyrion a unirse a su lucha y él acepta. En Meereen, los Hijos de la Arpía, un grupo de resistencia, asesina a uno de los Inmaculados. Danaerys es informada que la misión en Yunkai ha sido exitosa, los amos han entregado el control a un consejo conformado por esclavos, pero a cambio piden la reapertura de las arenas de combate. Más tarde visita a sus dragones Viserion y Rhaegal pero ellos parecen desconocerla y la intentan atacar. En el Valle, Brienne le informa a Podrick que no lo requiere más, dado que su misión de buscar a las hermanas Stark ha fallado, por otro lado, Sansa y Baelish ven como entrena Robyn Arryn antes de marcharse a un lugar en el que Baelish asegura los Lannister no los encontrarán. Stannis le pide a Jon convencer a Mance Rayder de arrodillarse ante el rey y entregar su ejército de salvajes para atacar Invernalia que está ocupada por Roose Bolton y a su vez les daría ciudadanía y tierras para vivir, sin embargo, Mance rechaza la oferta y es mandado a morir en la hoguera. Jon, incapaz de ver como Rayder sufre con las llamas decide darle una muerte rápida clavándole una flecha en el pecho.", date: dateFormatter.date(from: "2015-04-12")!, season: season5)
        _ = Episode(title: "La Casa de Negro y Blanco", number: 2, excerpt: "En Desembarco del Rey, Cersei recibe una estatua con el collar de su hija Myrcella y Jaime se dispone a ir por ella a Dorne, pidiendo la ayuda de Bronn. En el muro, Stannis le pide a Jon que se arrodille ante él y le jure lealtad; a cambio será reconocido como Jon Stark y se le otorgará Invernalia, sin embargo él rechaza la oferta, mientras tanto los hermanos de la Guardia de la Noche eligen al próximo Lord Comandante. En el Valle, Brienne y Podrick encuentran a Sansa con Petyr; tras la negación de Sansa por obtener la protección de Brienne, ella se dispone a seguir su caravana. En Braavos, Arya llega a la Casa de Negro y Blanco, pero se le niega la entrada y más tarde encuentra a Jaqen H'ghar. En Dorne, Ellaria le pide a Doran vengarse de la muerte de su hermano Oberyn torturando a Myrcella, pero él termina negándose a tal solicitud. Tyrion y Varys comienzan su viaje a Volantis. En Meereen, Daario y los Inmaculados encuentran un miembro de los Hijos de la Arpía, sin embargo, Mossador lo asesina antes de recibir su juicio, por tal motivo Daenerys ordena su ejecución pública, lo que genera un motín entre los amos y los esclavos liberados. Por la noche, Daenerys descubre que Drogon regresó a Meereen pero se marcha antes de que ella pueda tocarlo.", date: dateFormatter.date(from: "2015-04-19")!, season: season5)
        
        // Season 6 Episodes
        _ = Episode(title: "La mujer roja", number: 1, excerpt: "El futuro de Jon nieve pende de un hilo en el Muro tras el violento ataque de los amotinados; Melissandre tiene que tomar una decisión complicada. Daenerys continúa su huida después de abandonar las tierras de Meereen donde le llevan ante el nuevo Khal. En Braavos, Arya hace frente a su difícil situación e intenta sobrevivir. Tyrion se las arregla como puede en Meereen tras la marcha de sus compañeros que van en busca de Daenerys. Mientras tanto, Jaime consigue traer de vuelta a Myrcella a Desembarco del Rey.", date: dateFormatter.date(from: "2016-04-24")!, season: season6)
        _ = Episode(title: "A casa", number: 2, excerpt: "Más allá del Muro, Bran comienza su entrenamiento con el Cuervo de Tres Ojos, mientras que un joven Tommen es aconsejado por Jaime en Desembarco del Rey. Ramsay sigue con su peculiar modus operandi en el Norte y propone un plan tras la huida de Sansa y Theon. Éste último vuelve con su hermana Yara, en quien recae ahora el destino de los Greyjoy en Pyke.", date: dateFormatter.date(from: "2016-05-01")!, season: season6)
        
        // Season 7 Episodes
        _ = Episode(title: "Rocadragón", number: 1, excerpt: "En Los Gemelos, Arya Stark envenena a los Frey restantes implicados en la \"Boda Roja\". En Desembarco del Rey, Cersei Lannister y Jaime Lannister tratan con Euron Greyjoy intentando hacer una alianza. En Invernalia, Jon Nieve perdona a los Karstark y a los Umber haciendo que le juren lealtad, y Sansa Stark advierte a Jon de la inminente ira de Cersei. En Antigua, Samwell Tarly comienza su entrenamiento, y un enfermo Jorah Mormont le pregunta por la llegada de Daenerys. Bran Stark llega al Muro y es recibido por Edd el Penas. Sandor Clegane con la Hermandad sin Estandartes se refugia en la casa de un granjero. En Rocadragón, Daenerys Targaryen y Tyrion Lannister junto con su ejército llegan a Rocadragón y exploran el castillo abandonado que fue antes habitado por Stannis Baratheon.", date: dateFormatter.date(from: "2017-07-16")!, season: season7)
        _ = Episode(title: "Nacido de la tormenta", number: 2, excerpt: "Daenerys comienza a pensar estrategias junto a sus aliados. Melisandre llega a Rocadragón y pide a Daenerys que convoque a el Rey del Norte Jon Nieve. Sam intenta curar de psoriagrís a Jorah. Cersei entabla alianzas con los Tarly. Jon Nieve decide acudir a la llamada de Daenerys dejando Invernalia en manos de Sansa. Arya decide cambiar su rumbo hacia Invernalia, reencontrándose con su viejo amigo Pastel Caliente y su loba huargo Nymeria. Euron ataca la flota de su sobrina Yara. ", date: dateFormatter.date(from: "2017-07-23")!, season: season7)
        
        return [
            season1,
            season2,
            season3,
            season4,
            season5,
            season6,
            season7
        ].sorted()
    }
}
