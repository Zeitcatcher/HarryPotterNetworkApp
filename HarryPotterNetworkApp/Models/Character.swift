//
//  Character.swift
//  HarryPotterNetworkApp
//
//  Created by Arseniy Oksenoyt on 8/31/23.
//

struct Character: Codable {
    let name: String
    let otherNames: String?
    let house: String?
    let yearOfBirth: Int?
    let wand: Wand?
    let patronus: String?
    let alive: Bool?
    let imageURL: String?
    
    var characterDescription: String {
        """
        Other names: \(otherNames ?? "")
        School house: \(house ?? "")
        Born on: \(yearOfBirth ?? 0)
        Patronus: \(patronus ?? "")
        Is alive: \(alive ?? true)
        """
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case otherNames = "alternate_names"
        case house = "house"
        case yearOfBirth = "yearOfBirth"
        case wand = "wand"
        case patronus = "patronus"
        case alive = "alive"
        case imageURL = "image"
    }
}

struct Wand: Codable {
    let wood: String?
    let core: String?
    let length: Double?
    
    var wandDescription: String {
        """
        Wood: \(wood ?? "")
        Core: \(core ?? "")
        Lenght: \(length ?? 1)
        """
    }
}
