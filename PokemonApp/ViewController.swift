//  ViewController.swift
//  PokemonApp
//  Created by Alexandru Meta on 30.04.2023.

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    // Important stuff
    var nameOfPokemonsList = [String]()
    
    var searchList = [String]()
    var isSearching = false
    
    var pokemonDetailed = PokemonModel(base_experience: 1, id: 1, height: 1, weight: 1, order: 1)
    
    var listOfPokemons = [Pokemon]()
    
    
    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromApiAndDecode {
            self.pokemonTableView.reloadData()
            print("Success")
        }
        
        searchBar.delegate = self
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
    }
    // ViewDidLoad ends here
    
    /*
     
     
    */
    
    // Fetching data from the API functions
    
    func fetchDataFromApiAndDecode(completed: @escaping () -> ()) {
        
        let url = URL(string: Constants.pokeApiURL)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    let decodedData = try JSONDecoder().decode(PokemonDataResponse.self, from: data!)
                    let counter = decodedData.results.count
                    
                    for number in 0...counter-1 {
                        self.listOfPokemons.append(Pokemon(name: decodedData.results[number].name, url: decodedData.results[number].url))
                        
                        // used for search list
                        self.nameOfPokemonsList.append(decodedData.results[number].name)
                    }
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func fetchDataFromIndividualPokemonLink(url: String, pokemonDetailed: PokemonModel) {
        
        let detailedURL = URL(string: url)
        
        URLSession.shared.dataTask(with: detailedURL!) { data, response, error in
            
            if error == nil {
                do {
                    let decodedData = try JSONDecoder().decode(PokemonDetails.self, from: data!)
                    self.pokemonDetailed = PokemonModel(base_experience: decodedData.base_experience, id: decodedData.id, height: decodedData.height, weight: decodedData.weight, order: decodedData.order)
                }
                catch {
                    print(error)
                }
            }
        }
        .resume()
    }
}




extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchList.count
        } else {
            return listOfPokemons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemons = listOfPokemons[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        if isSearching {
            cell.textLabel?.text = searchList[indexPath.row]
        } else {
            cell.textLabel?.text = pokemons.name.capitalized
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = true
        searchList = nameOfPokemonsList.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        pokemonTableView.reloadData()
    }
}
