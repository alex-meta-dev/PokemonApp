//  ViewController.swift
//  PokemonApp
//  Created by Alexandru Meta on 30.04.2023.

// Last refactored 1-May-2023 @10:24am

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
// MARK: - List of pokemons structs, searchList, detailed pokemon
    var nameOfPokemonsList = [String]()
    
    var searchList = [String]()
    var isSearching = false
    
    var pokemonDetailed = PokemonModel(base_experience: 1, id: 1, height: 1, weight: 1, order: 1)
    
    var listOfPokemons = [Pokemon]()
    
    
// MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    
// MARK: - viewDidLoad()
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
// MARK: - viewDidLoad() ends here
    
// MARK: - Fetch & decode data from PokeAPI functions
    
    // Download data from the "results" endpoint, a list of [Pokemons], each Pokemon has a name and URL, each individual URL has details about
    // each Pokemon, such as stats...
    func fetchDataFromApiAndDecode(completed: @escaping () -> ()) {
        
        let url = URL(string: Constants.pokeApiURL)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    let decodedData = try JSONDecoder().decode(PokemonDataResponse.self, from: data!)
                    let counter = decodedData.results.count
                    
                    // Adding the Pokemons to the list
                    for number in 0...counter-1 {
                        self.listOfPokemons.append(Pokemon(name: decodedData.results[number].name, url: decodedData.results[number].url))
                        
                        // Used for search list
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
        }.resume() // Starting the task
    }
    
    // Downloading data for each individual Pokemon
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
        .resume() // Starting the task
    }
}

// MARK: - TableView Extensions

extension ViewController: UITableViewDataSource {
    
    // Displaying number of rows in the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchList.count
        } else {
            return listOfPokemons.count
        }
    }
    
    // Cells
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
    
    // Function for when it's tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        fetchDataFromIndividualPokemonLink(url: listOfPokemons[indexPath.row].url, pokemonDetailed: pokemonDetailed)
        performSegue(withIdentifier: Constants.segueToDetails, sender: self)
    }
    
    // Data that needs to be sent to the destination VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.segueToDetails {
            let pokemonDetailedViewController = segue.destination as! PokemonDetailsUIViewController
            
            // Each pokemon has a different ID, each image has the same URL but with a different ID at the end
            pokemonDetailedViewController.pokemonImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonDetailed.id).png"
            
            // Stats for the Pokemons
            pokemonDetailedViewController.pokemonBaseXP = String(pokemonDetailed.base_experience)
            pokemonDetailedViewController.pokemonOrder = String(pokemonDetailed.order)
            pokemonDetailedViewController.pokemonHeight = String(pokemonDetailed.height)
            pokemonDetailedViewController.pokemonWeight = String(pokemonDetailed.weight)
        }
    }
}

// MARK: - SearchBar Extension
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = true
        searchList = nameOfPokemonsList.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        pokemonTableView.reloadData()
    }
}

// MARK: - File ends here.

