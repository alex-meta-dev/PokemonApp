//  PokemonData.swift
//  PokemonApp
//  Created by Alexandru Meta on 30.04.2023.

// Last refactored 1-May-2023 @11:14

import Foundation

// MARK: - Structures for the API Response

struct PokemonDataResponse: Codable {
    
    // API Returns a list of Pokemons, each list has a name and a url
    var results: [Pokemon]
}

struct Pokemon: Codable {
    
    let name: String
    let url: String
}

struct PokemonDetails: Codable {
    
    // line 11 ---> each url has stats for their respective Pokemon
    let base_experience: Int
    let id: Int
    let height: Int
    let weight: Int
    let order: Int
}

// MARK: - File ends here
