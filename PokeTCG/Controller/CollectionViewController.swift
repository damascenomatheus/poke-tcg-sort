//
//  CollectionViewController.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 16/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {
    
    
   var pokes = [PokemonObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let fetch = CoreDataHandler.sharedInstance.fetchPokemon()
        if fetch == nil {
            self.pokes = [PokemonObject]()
        } else { self.pokes = fetch! }
        
        
        
        registerForPreviewing(with: self, sourceView: collectionView)
        
        let nib = UINib.init(nibName: "CardCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: "Cell")
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pokes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        
        cell.imageView.image = pokes[indexPath.row].image
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokeSegue" {
            let vc: PackageViewController = segue.destination as! PackageViewController
            vc.delegate = self
        }
    }
    
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at: location) else {
            return nil
        }
        
        return viewControllerForIndexPath(indexPath: indexPath)
    }
    
    func viewControllerForIndexPath(indexPath: IndexPath) -> PokemonPeekAndPopViewController {
        
        let pokemonController = PokemonPeekAndPopViewController()
        let pokemonPeekAndPop = pokes[indexPath.row]
        pokemonController.pokemon = pokemonPeekAndPop
    
        
        return pokemonController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) { }
    
    
}

extension CollectionViewController: PokeDelegate {
    func sortedOnePokemon(poke: PokemonObject) {
        pokes.append(poke)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


