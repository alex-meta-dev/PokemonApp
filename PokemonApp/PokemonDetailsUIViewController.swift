//  PokemonDetailsUIViewController.swift
//  PokemonApp
//  Created by Alexandru Meta on 01.05.2023.


import UIKit

class PokemonDetailsUIViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonImage: UIImageView?
    
    
    var pokemonImageURL: String?
    var pokemonBaseXP: String?
    var pokemonOrder: String?
    var pokemonHeight: String?
    var pokemonWeight: String?
    
    @IBOutlet weak var baseExperienceLabel: UILabel?
    @IBOutlet weak var orderLabel: UILabel?
    @IBOutlet weak var heightLabel: UILabel?
    @IBOutlet weak var weightLabel: UILabel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage(with: pokemonImageURL!)
        DispatchQueue.main.async {
            self.baseExperienceLabel?.text = self.pokemonBaseXP
            self.orderLabel?.text = self.pokemonOrder
            self.heightLabel?.text = self.pokemonHeight
            self.weightLabel?.text = self.pokemonWeight
        }
    
    }
    
    func downloadImage(with imageURL: String) {
        if let url = URL(string: imageURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.pokemonImage!.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
}
