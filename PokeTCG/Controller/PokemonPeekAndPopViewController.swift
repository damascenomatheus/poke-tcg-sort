//
//  PokemonPeekAndPopViewController.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 22/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit

class PokemonPeekAndPopViewController: UIViewController {

//    @IBOutlet weak var pokemonImage: UIImageView!
    
    var pokemon: PokemonObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let pokemon = pokemon {
//            pokemonImage.image = pokemon.image
            let t = UIImageView(image: UIImage())
            t.center = view.center
            t.bounds = UIScreen.main.bounds
            t.image = pokemon.image
            t.contentMode = .scaleAspectFit
            view.addSubview(t)
        }
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let favoriteAction = UIPreviewAction(title: "Favorite", style: .default) { (action, viewController) in
         
            if let pokeDB = CoreDataHandler.sharedInstance.pokemonObjectToPokeDB(poke: self.pokemon) {
                pokeDB.favorited = true
                CoreDataHandler.sharedInstance.appDelegate.saveContext()
            }
        }
        
        return [favoriteAction]
    }
}
