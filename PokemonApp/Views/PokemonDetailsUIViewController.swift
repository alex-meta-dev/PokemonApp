//  PokemonDetailsUIViewController.swift
//  PokemonApp
//  Created by Alexandru Meta on 01.05.2023.

// Last refactored 1-May-2023 @11:07

import UIKit

class PokemonDetailsUIViewController: UIViewController {
    
// MARK: - IBOutlets
    @IBOutlet weak var pokemonImage: UIImageView?
    @IBOutlet weak var baseExperienceLabel: UILabel?
    @IBOutlet weak var orderLabel: UILabel?
    @IBOutlet weak var heightLabel: UILabel?
    @IBOutlet weak var weightLabel: UILabel?
    
// MARK: - Variables for labels & image
    var pokemonImageURL: String?
    var pokemonBaseXP: String?
    var pokemonOrder: String?
    var pokemonHeight: String?
    var pokemonWeight: String?
    
    
// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage(with: pokemonImageURL!)
        labelConfigurator()
    }
    
// MARK: - viewDidLoad() ends here
    
    // To be executed on viewDidLoad()
    func labelConfigurator() {
        
        DispatchQueue.main.async {
            self.baseExperienceLabel?.text = "⏳ Base Experience: \(self.pokemonBaseXP!)"
            self.orderLabel?.text = "🔥 Order: \(self.pokemonOrder!)"
            self.heightLabel?.text = "📏 Height: \(self.pokemonHeight!)"
            self.weightLabel?.text = "⚖️ Weight: \(self.pokemonWeight!)"
        }
    }
    
    // Function to download image from URL
    func downloadImage(with imageURL: String) {
        
        if let url = URL(string: imageURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.pokemonImage!.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}

// MARK: - File ends here
