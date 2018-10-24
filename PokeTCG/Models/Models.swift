//
//  Models.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 17/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let imageUrlHiRes: String
}

struct Card: Codable {
    let cards: [Pokemon]
}
