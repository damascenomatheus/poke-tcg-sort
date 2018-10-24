//
//  FavoritedTableViewController.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 17/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit

class FavoritedTableViewController: UITableViewController {

    
    @IBOutlet weak var editButton: UIBarButtonItem!
    var pokemonFavorited = [PokemonObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "FavoriteCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TableCell")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fetch = CoreDataHandler.sharedInstance.fetchPokemon()
        if fetch == nil {
            self.pokemonFavorited = [PokemonObject]()
        } else {
            let pokemonFilters = fetch?.filter({ (poke) -> Bool in
                return poke.favorite == true })
            self.pokemonFavorited = pokemonFilters! }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonFavorited.count
    }

    @IBAction func setEdit(_ sender: Any) {
        if editButton.title == "Edit" {
            tableView.setEditing(true, animated: true)
            editButton.title = "Done"
            
        } else {
            tableView.setEditing(false, animated: true)
            editButton.title = "Edit"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let pokeDB = CoreDataHandler.sharedInstance.pokemonObjectToPokeDB(poke: self.pokemonFavorited[indexPath.row]) {
                pokeDB.favorited = false
                CoreDataHandler.sharedInstance.appDelegate.saveContext()
            }
            self.pokemonFavorited.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell

        cell.favoriteImageCell.image = pokemonFavorited[indexPath.row].image
        cell.favoriteNameCell.text = pokemonFavorited[indexPath.row].name
        
        

        return cell
    }
}
