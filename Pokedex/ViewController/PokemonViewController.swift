//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Life on 6/5/22.
//

import Foundation
import UIKit

class  PokemonViewController: UIViewController{
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numerLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        type2Label.text = ""
        type1Label.text = ""
        if let url = URL(string: pokemon.url){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let safeData = data{
                    do{
                        let pokemonData = try JSONDecoder().decode(PokemonData.self, from: safeData)
                        DispatchQueue.main.async {
                         
                        self.nameLabel.text = self.pokemon.name
                        self.numerLabel.text = String(format: "#%03d", pokemonData.id)
                        for typeEntry in pokemonData.types{
                            if typeEntry.slot == 1 {
                                self.type1Label.text = typeEntry.type.name
                            } else if typeEntry.slot == 2 {
                                self.type2Label.text=typeEntry.type.name
                            }
                        }
                       
                           
                        }
                       
                    }catch let error {
                        print("\(error)")
                    }
                }
            }.resume()
        }
    }
}
