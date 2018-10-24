
//
//  PokemonObject.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 17/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit
import CoreData

class PokemonObject {
    
    var name: String
    var image: UIImage
    var favorite: Bool
    var id: NSManagedObjectID?
    
    
    init(newName: String, newImage: UIImage, favoriteStatus:Bool, newId: NSManagedObjectID? = nil) {
        name = newName
        image = newImage
        favorite = favoriteStatus
        id = newId
    }

}
