//  PokemonDetailsUIViewController.swift
//  PokemonApp
//  Created by Alexandru Meta on 01.05.2023.


import UIKit

class PokemonDetailsUIViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonImage: UIImageView?
    
    
    var pokemonImageURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage(with: pokemonImageURL!)
    
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
