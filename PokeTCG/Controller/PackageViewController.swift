//
//  PackageViewController.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 17/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit

protocol PokeDelegate {
    func sortedOnePokemon(poke: PokemonObject)
}

class PackageViewController: UIViewController {
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var pokemonSortedImage: UIImageView!
    
    var delegate: PokeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func dismissController(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func packOpening(_ sender: Any) {
        
        loadingActivity.startAnimating()
        if delegate != nil {
            JSONHandler.sharedInstance.doGetRequest { (poke) in
                let pokemon = PokemonObject(newName: (poke?.name)!, newImage: (poke?.image)!, favoriteStatus: (poke?.favorite)!)
                self.delegate?.sortedOnePokemon(poke: pokemon)
                DispatchQueue.main.async {
                    self.pokemonSortedImage.image = poke?.image
                }
                CoreDataHandler.sharedInstance.insertPokemon(poke: pokemon)
                DispatchQueue.main.async {
                    self.loadingActivity.stopAnimating()
                }
            }
        }
        
    }
}
