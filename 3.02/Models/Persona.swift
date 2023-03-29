//
//  Hero.swift
//  3.02
//
//  Created by Айдар Оспанов on 23.03.2023.
//


struct Persona: Decodable {
    let results: [Hero]
    
    static func getHeroes(from value: Any) -> [Hero] {
        guard let personaData = value as? [String: Any] else { return [] }
        guard let heroesData = personaData["results"] as? [[String: Any]] else {
            return []
        }
        
        return heroesData.map { Hero(heroData: $0) }
    }
}

struct Hero: Decodable {
    let name: String
    let status: Status
    let species: Species
    let gender: Gender
    let location: Location
    let image: String
    let created: String
    
    var description: String {
        """
        Name: \(name)
        Status: \(status.rawValue)
        """
    }
    
    var fullInfo: String {
        """
        Status: \(status.rawValue)
        Species: \(species.rawValue)
        Location: \(location.name)
        Gender: \(gender.rawValue)
        Created: \(created)
        """
    }
    
    init(heroData: [String: Any]) {
    name =  heroData["name"] as? String  ?? ""
    status = Status(rawValue: heroData["status"] as? String ?? "") ?? .unknown
    species = Species(rawValue: heroData["species"] as? String ?? "") ?? .human
    gender = Gender(rawValue: heroData["gender"] as? String ?? "") ?? .unknown
    location = Location.getLocation(value: heroData["location"] ?? "")
    image = heroData["image"] as? String ?? ""
    created = heroData["created"] as? String ?? ""
    }
}

struct Location: Decodable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(heroLocation: [String: Any]) {
        name = heroLocation["name"] as? String ?? ""
    }
    
    static func getLocation(value: Any) -> Location {
        guard let heroLaction = value as? [String: Any] else {
            return Location(name: "")
        }
        return Location(heroLocation: heroLaction)
    }
}

enum Gender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

enum Species: String, Decodable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
