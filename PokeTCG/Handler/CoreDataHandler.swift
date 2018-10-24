//
//  CoreDataHandler.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 19/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler {
    
    static let sharedInstance = CoreDataHandler()
    
    let (appDelegate, persistentContainer): (AppDelegate, NSPersistentContainer) = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let container = delegate.persistentContainer
        
        return (delegate, container)
    }()
    
    private init () {}
    
    func insertPokemon(poke: PokemonObject) {
        
        let managedContext = persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "PokeDB", in: managedContext)
        
        let user = NSManagedObject(entity: userEntity!, insertInto: managedContext)
        
        user.setValue(poke.name, forKey: "name")
        user.setValue(false, forKey: "favorited")
        
        let imagePath = "\(poke.name)Image"
        user.setValue(imagePath, forKey: "imagePath")
        saveImageInFileManager(poke.image, at: imagePath)
        
        appDelegate.saveContext()
    }
    
    func fetchPokemon() -> [PokemonObject]? {
    
        var pokemons: [PokemonObject] = []
        
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PokeDB")
        do {
            let pokemonsFetched = try persistentContainer.viewContext.fetch(request) as! [PokeDB]
            pokemonsFetched.forEach { (pokemonFetched) in
                pokemons.append(PokemonObject(
                    newName: pokemonFetched.name!,
                    newImage: getImageFrom(path: pokemonFetched.imagePath!) ?? UIImage(),
                    favoriteStatus: pokemonFetched.favorited,
                    newId: pokemonFetched.objectID)
                )
            }
        } catch {
            return nil
        }
        
        return pokemons
        
    }
    
    func pokemonObjectToPokeDB(poke: PokemonObject?) -> PokeDB? {
        let context = persistentContainer.viewContext
        guard let actualID = poke?.id else {
            return nil
        }
        
        if let pokeDB = try? context.existingObject(with: actualID) as? PokeDB {
            return pokeDB
        }
        return nil
    }
    

    
    func deleteAllFrom(entity: String) {
        let fetchPokemon = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deletePokemon = NSBatchDeleteRequest(fetchRequest: fetchPokemon)
        
        do {
            try persistentContainer.viewContext.execute(deletePokemon)
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func saveImageInFileManager(_ image: UIImage, at path: String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            .first! as NSString).strings(byAppendingPaths: [path]).first!
        
        let imageData = UIImage.pngData(image)()
        
        fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
    }
    
    private func getImageFrom(path: String) -> UIImage? {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString).strings(byAppendingPaths: [path]).first!
        if fileManager.fileExists(atPath: imagePath) {
            return UIImage(contentsOfFile: imagePath)
        }
        
        return nil
    }    
    
}
