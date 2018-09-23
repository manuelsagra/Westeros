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

typealias SeasonToBool = (Season) -> Bool
protocol SeasonFactory {
    var seasons: [Season] { get }
}

final class LocalFactory {
    
}

extension LocalFactory: HouseFactory {
    enum HouseNames: String {
        case Stark = "Stark"
        case Lannister = "Lannister"
        case Targaryen = "Targaryen"
    }
    
    var houses: [House] {
        // Sigils        
        let starkSigil = Sigil(image: UIImage(named: "stark.jpg")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "León Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryen.jpg")!, description: "Dragón Tricéfalo")
        
        // Houses
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        // Characters
        _ = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse, photo: UIImage(named: "robb.jpg")!)
        _ = Person(name: "Arya", house: starkHouse, photo: UIImage(named: "arya.jpg")!)
        _ = Person(name: "Eddard", alias: "Ned", house: starkHouse, photo: UIImage(named: "ned.jpg")!)
        
        _ = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse, photo: UIImage(named: "tyrion.jpg")!)
        _ = Person(name: "Cersei", house: lannisterHouse, photo: UIImage(named: "cersei.jpg")!)
        _ = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse, photo: UIImage(named: "jaime.jpg")!)
        
        _ = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse, photo: UIImage(named: "daenerys.jpg")!)
        
        return [
            starkHouse,
            lannisterHouse,
            targaryenHouse
        ].sorted()
    }
    
    func house(named: String) -> House? {
        return houses.first { $0.name.lowercased() == named.lowercased() }
    }
    
    func house(named enumValue: HouseNames) -> House? {
        return house(named: enumValue.rawValue)
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
        let season1 = Season(name: "Temporada 1", date: dateFormatter.date(from: "2011-04-17")!, excerpt: "Comienza cuando el Rey Robert Baratheon le pide a su viejo amigo Ned Stark que realice la función de nuevo consejero real (cargo conocido como la Mano del Rey). La esposa de Ned, Catelyn recibe una carta de su hermana, Lysa que le da razones para creer que la Casa Lannister, a la cual pertenece Cercei, la esposa del rey, está involucrada en la muerte de la anterior Mano del Rey. Ned debe viajar al Sur con el Rey para descubrir el asesino de la Mano del Rey muerto, Jon Arryn y a la misma vez proteger a su familia de los Lannister. Mientras descubre las razones detrás de la muerte de Jon, desentierra el oscuro secreto concerniente a los Lannister que el propio Arryn murió tratando de revelar.\n\nMientras tanto, del otro lado del Mar Angosto, en el continente de Essos, el exiliado Viserys Targaryen, hijo del anterior rey cuyo trono fue usurpado por Robert Baratheon, cree ser el verdadero heredero al trono y por lo tanto debe reclamarlo. Viserys une en matrimonio a su hermana, Daenerys Targaryen, la cual ha sido abusada física y psicológicamente por su hermano, con el líder de la tribu de guerreros Dothraki, Khal Drogo, a cambio de un ejército para regresar a Poniente y reclamar su trono. Pero, el creciente amor de Daenerys hacia Drogo y la fortaleza que encuentra siendo la Khaleesi de la tribu, hace que los planes de Viserys fracasen rotundamente.\n\nEn el Muro, el hijo bastardo de Ned, Jon Nieve se une a La Guardia de la Noche, una antigua hermandad jurada a proteger las tierras del sur del Muro de los salvajes que viven al norte; pero una antigua fuerza, que por mucho tiempo se pensó desaparecida, amenaza con destrucción.")
        let season2 = Season(name: "Temporada 2", date: dateFormatter.date(from: "2012-04-01")!, excerpt: "La segunda temporada abarca varios meses en un mundo donde las estaciones duran años a la vez. Los Siete Reinos están en guerra con el Rey en el Norte Robb Stark luchando por ganar la independencia de su pueblo. Theon Greyjoy le pide a Robb que lo envíe a Pyke para buscar una alianza con su padre, Balon Greyjoy, aduciendo su necesidad de barcos para atacar Desembarco del Rey. Pero Theon regresa a Pyke y descubre los planes de su padre para nombrarse Rey de las Islas del Hierro. Mientras tanto, Joffrey Baratheon sostiene el Trono de Hierro con el respaldo de la poderosa Casa Lannister . Pero su tío Renly también ha reclamado el trono con el apoyo de la Casa Tyrell cuyos ejércitos son mucho más grandes. A medida que luchan por el trono, Tyrion llega a Desembarco del Rey para ayudar al rey Joffrey como su Mano sólo para hacer frente a la oposición d su hermana Cersei ahora la reina Regente.\n\nSin embargo Stannis Baratheon el hermano menor de Robert y hermano mayor de Renly, también ha reclamado el Trono de Hierro. Un veterano de varias guerras, Stannis es conocido por ser completamente un hombre sin misericordia para sus enemigos y hará lo que es correcto incluso si lo destruye. Es aconsejado por Melisandre, un enigmática sacerdotisa roja que cree que Stannis está destinado a un destino mayor y Ser Davos Seaworth un hombre honesto y honorable incómodo con los cambios en el poder en la corte de Stannis.\n\nEn Essos, Daenerys Targaryen ha eclosionado a los tres únicos dragones del mundo. Con su khalasar desaparecido, Daenerys y su pequeño grupo de seguidores deben encontrar un camino a través de un imponente terreno baldío y encontrar nuevos aliados para apoyar su reclamación al Trono de Hierro.\n\nEn el lejano norte, la Guardia de la Noche ha montado una expedición más allá del Muro en busca de exploradores desaparecidos e investigando rumores de salvajes que se reúnen en las montañas. Para Jon Snow este será un rito de paso ya que se le pide que tome decisiones difíciles, para el reino y para sí mismo.")
        let season3 = Season(name: "Temporada 3", date: dateFormatter.date(from: "2013-03-21")!, excerpt: "espués de la derrota de Stannis Baratheon en la Batalla de Aguasnegras, El cruel rey Joffrey Baratheon ha ganado una gran victoria asegurando una alianza con la casa Tyrell; y además Joffrey ahora comanda los ejércitos más grandes en el reino y su triunfo parece inevitable.Mientras tanto, Tyrion Lannister ha perdido poder cuando era la Mano del Rey, y siente que su padre no aprecia el servicio que prestó a la familia como Mano. Mientras tanto, Jaime Lannister continúa su intento de volver a casa, y comienza a formar un vínculo con su compañera de viaje Brienne de Tarth.\n\nLos Starks está perdiendo la guerra además perdieron el apoyo de Walder Frey, después de que Robb Stark rompió su promesa al casarse con Talisa Maegyr, y muchos miembros del ejército de Robb están perdiendo la fe en él y su relación con su madre Catelyn Tully también se ha vuelto fría después de ella libero al Jaime Lannister. Mientras, Bran y Rickon Stark continúan su viaje hacia el norte con unos nuevos aliados extraños que son los hermanos Reed. Theon Greyjoy debe enfrentar las consecuencias de sus acciones en Invernalia y será torturado por Ramsay. Arya Stark continua en su viaje a casa con Gendry y Pastel caliente pero se encontrarla con La Hermandad sin Estandartes y con otra persona que es Sandor Clegane. Sansa Stark permanece en Desembarco de rey como una prisionera de los Lannister pero se le ofrece ayuda tanto por el traicionero Petyr Baelish como por los Tyrell.\n\nEn Rocadragon, aparece un hombre que sobrevivió después de ser aplastado en la batalla de Aguasnegras que es Ser Davos pero es encarcelado después de intentar matar a Melisandre, quien todavía cree que su dios, el Señor de la Luz, ayudará a Stannis.\n\nMás allá del muro, Jon Nieve se une al ejército de rey más allá de muro Mance Rayder, pero con un objetivo: espiar a los salvajes. Pero rompe sus votos con una mujer salvaje Ygritte, el tendrá que elegir entre ella o la guardia de la noche. Sin embargo, muchos de los hombres de la guardia también cuestionan sus votos, poniendo en peligro las vidas de Lord Comandante Jeor Mormont y Samwell Tarly.\n\nEn Essos, Daenerys Targaryen continúa su viaje para recuperar los siete reinos. Ella tiene un nuevo compañero Barristan Selmy, y Jorah Mormont. Además contempla la compra de los Inmaculados, un ejército de élite de eunucos severamente entrenados son controlados por un amo cruel con una joven traductora inteligente, Missandei.")
        let season4 = Season(name: "Temporada 4", date: dateFormatter.date(from: "2014-04-06")!, excerpt: "Los Lannister lograron ganar en el campo de batalla con el apoyo de la Casa Tyrell prometiendo una alianza matrimonial entre el rey Joffrey y Margaery Tyrell. En Desembarco del Rey celebra la boda del rey Joffrey Baratheon con Margaery Tyrell, pero Joffrey es envenenado durante esta y muere. Y Cersei ordena la detención de Tyrion acusándolo de asesinar al rey. Mientras tanto Sansa Stark que es la esposa de Tyrion escapa con éxito con la ayuda de Petyr Baelish. Baelish la lleva al Valle de Arryn donde entra en conflicto con su celosa tía, Lysa Arryn.\n\nMientras tanto, Arya Stark habiendo perdido todo y obligada a confiar en la protección de Sandor Clegane un sujeto a quien odia, pero se aferra a la supervivencia y a su sed de venganza. Y mas allá de muro, Bran Stark, acompañado por Hodor, Jojen y Meera Reed sigue con su viaje de encontrar el cuervo de tres ojos.\n\nEn el Muro, Jon Nieve y los de la guardia de la noche se prepara para un inminente ataque de los salvajes liderado por el rey mas allá de muro Mance Rayder. Mientras tanto, Stannis Baratheon como legítimo heredero de su hermano mayor, el rey Robert todavía se niega a rendirse a pesar de tener un ejercito reducido. Sin embargo, siguiendo el consejo de Melisandre ha centrado su atención al muro sobre la amenaza de los salvajes que marcha contra el Muro.\n\nEn Essos, Daenerys Targaryen ahora con los tres últimos dragones y con un ejercito de 8000 inmaculados se dirige a Meeren con un objetivo que es la liberación de los esclavos.")
        let season5 = Season(name: "Temporada 5", date: dateFormatter.date(from: "2015-04-12")!, excerpt: "En Meereen, los Hijos de la Arpía comienza a rebelarse contra el régimen de Daenerys Targaryen, entonces para recuperar la paz y el control de la ciudad, Daenerys cumple con la solicitud de reabrir los fosos de combate mientras toma a Hizdahr zo Loraq como su esposo. Mientras tanto, Tyrion Lannister y Varys llegan a Pentos y comienzan su viaje a Meereen para conocer a Daenerys. Pasan por Volantis, donde Tyrion es secuestrado por Jorah Mormont, quien lo lleva a Meereen como una forma de redimirse a Daenerys.\n\nEn el Muro, el recién elegido Lord Comandante de la Guardia de la noche, Jon Nieve forma una alianza con los salvajes de evacuar a los otros salvajes que esta mas alla de muro especialmente en casa Austera, pero Jon se gana el odio y resentimiento de algunos de la guardia de la noche que lo ve como un traidor.\n\nEn Invernalia, Sansa Stark es comprometida por obra de Petyr Baelish a matrimonio con Ramsay Bolton para formar una alianza entre el Valle y los Bolton. Pero Ramsay somete a Sansa a un abuso físico y psicológico presenciado por Theon Greyjoy. Mientras tanto, Stannis Baratheon planear invadir a Invernalia.\n\nEn Desembarco del Rey, después de la boda de Margaery Tyrell y Tommen Baratheon, Cersei Lannister autoriza el renacimiento de la Fe militante y los Gorriones comienzan a imponer sus puntos de vista puritanos sobre Desembarco del Rey librándolo de todos los \"pecados\". Proceden a encarcelar a Loras Tyrell, así como a la propia Margaery y Cersei por cometer varios pecados.\n\nEn Dorne, las serpientes de arena(hijas bastardas de Oberyn Martell) junto con Ellaria Arena, buscan venganza por su muerte. Después de que Dorne enviara un mensaje amenazante al Desembarco del Rey, Jaime Lannister y Bronn viajan a Dorne para rescatar a Myrcella Baratheon. Arya Stark llega a Braavos y comienza a entrenar con los Hombres sin rostro, guiados por Jaqen H'ghar y la niña abandonada.")
        let season6 = Season(name: "Temporada 6", date: dateFormatter.date(from: "2016-04-24")!, excerpt: "Tras su escape de Invernalia, Sansa Stark viaja al Muro con Brienne de Tarth para reencontrarse con su hermano Jon Nieve que fue asesinado por los de la Guardia de la noche pero sera revivido gracias a Melisandre, mientras que Theon Greyjoy regresa a las Islas de Hierro. En Invernalia, Ramsay Bolton asegura su reclamo del Norte tras matar a su padre Roose. Más allá del Muro, Bran Stark entrena con el Cuervo de Tres Ojos, pero alerta al Rey de la Noche, quien lanza un ataque a la guarida.\n\nEn Desembarco del Rey, Jaime Lannister y el ejército Tyrell intentan liberar a Margaery y Loras, pero Margaery ha abrazado la Fe de los Siete y Tommen forja una alianza con la Fe. Tommen releva a Jaime de sus deberes como Guardia Real y le ordena que ayude a Walder Frey al expulsar al Pez negro de Aguasdulces. Mientras Cersei debe esperar su juicio. En Dorne, Ellaria Arena y las tres hijas de Oberyn Martell matan a Doran y Trystane Martell y toman el control de Dorne.\n\nEn Braavos, Arya continúa su entrenamiento con los Hombres Sin Rostro; y pronto recupera la vista. Mientras tanto Sam Tarly, Gilly y su hijo viajan a la Ciudadela.\n\nEn Essos, Daenerys Targaryen es capturada por Khal Moro quien la lleva ante los khals pero los quema vivos cuando se niegan a servirla y toman el mando de los Dothraki y en Meeren Tyrion Lannister y Varys trae una paz estable a Meereen.")
        let season7 = Season(name: "Temporada 7", date: dateFormatter.date(from: "2017-07-16")!, excerpt: "La séptima temporada se centra principalmente en la convergencia de los principales argumentos de la serie, con eventos importantes como Daenerys Targaryen llegando a Westeros con su ejército y tres dragones y librando una guerra contra los Lannister, Jon Snow forjando una alianza con Daenerys en un intento de unir su fuerzas contra el ejército del Caminante Blanco, Arya y Bran regresando a Winterfell y reuniéndose con su hermana Sansa, y el ejército de los muertos rompiendo el Muro (con la ayuda de un dragón) y entrando en los Siete Reinos.")
        
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
    
    func seasons(filteredBy: SeasonToBool) -> [Season] {
        return seasons.filter(filteredBy)
    }
}
