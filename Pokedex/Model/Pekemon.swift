//
//  Pekemon.swift
//  Pokedex
//
//  Created by Life on 6/5/22.
//

import Foundation


struct PokemonList:Codable{
    let results:[Pokemon]
}
struct Pokemon:Codable{
    let name:String
    let url:String
}

//MARK:- on fetching new url we can get  abilities, forms , game-indices, height, id .... etc
///we chose id and types
/// in types we chose name and url
struct PokemonData: Codable {
    let id: Int
    let types: [PokemonTypeEntry]
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}
struct PokemonType: Codable {
    let name: String
    let url: String
}



