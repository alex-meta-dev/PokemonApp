//  PokemonData.swift
//  PokemonApp
//  Created by Alexandru Meta on 30.04.2023.

import Foundation

struct PokemonDataResponse: Codable {
    
    var results: [Pokemon]
}

struct Pokemon: Codable {
    
    let name: String
    let url: String
}

struct PokemonDetails: Codable {
    
    let base_experience: Int
    let id: Int
    let height: Int
    let weight: Int
    let order: Int
}
