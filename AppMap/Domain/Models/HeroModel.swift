
import UIKit

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool?
}

struct HeroLocation: Decodable {
    let id: String
    let latitud: Double
    let longitud: Double
    let dateShow: Date
    let hero: HeroID
    
    struct HeroID: Decodable {
        let id: String
    }
}
