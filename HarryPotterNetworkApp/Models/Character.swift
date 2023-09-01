//
//  Character.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 8/31/23.
//

struct Character: Decodable {
    let name: String
    let alternate_names: String
    let house: String
    let yearOfBirth: Double
    let wand: Wand
    let patronus: String
    let alive: Bool
    let image: String
    
    var characterDescription: String {
        """
        Other names: \(alternate_names)
        School house: \(house)
        Born on: \(yearOfBirth)
        Wand: \(wand)
        Patronus: \(patronus)
        Is alive: \(alive)
        """
    }
}

struct Wand: Decodable {
    let wood: String
    let core: String
    let length: Double
    
    var wandDescription: String {
        """
        Wood: \(wood)
        Core: \(core)
        Lenght: \(length)
        """
    }
}
