//
//  Hero.swift
//  3.02
//
//  Created by Айдар Оспанов on 23.03.2023.
//


struct Persone: Decodable {
    let results: [Hero]
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
        Status: \(status)
        Gender: \(gender)
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
}

struct Location: Decodable {
    let name: String
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
