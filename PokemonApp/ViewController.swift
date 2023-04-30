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
    }
    
    // Fetching data from the API functions
    
    func fetchDataFromApiAndDecode() {
        
    }
    
    func fetchDataFromIndividualPokemonLink() {
        
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        <#code#>
    }
}
