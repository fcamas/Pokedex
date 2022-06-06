//
//  ViewController.swift
//  Pokedex
//
//  Created by Life on 6/5/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var pokemon: [Pokemon] = []
    
    func capitalize(text:String) ->String{
        return text.prefix(1).uppercased()+text.dropFirst()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=150"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let safeData = data{
                    do{
                        let pokemonlist = try JSONDecoder().decode(PokemonList.self, from: safeData)
                        
                        self.pokemon = pokemonlist.results
                        Dispatch.DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                       
                    }catch let error {
                        print("\(error)")
                    }
                }
            }.resume()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        cell.textLabel?.text = capitalize(text:pokemon[indexPath.row].name)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonSegue" {
            if let destination = segue.destination as? PokemonViewController {
                destination.pokemon = pokemon[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}

