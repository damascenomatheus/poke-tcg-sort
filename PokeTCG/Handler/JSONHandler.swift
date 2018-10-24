//
//  JSONHandler.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 16/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit

class JSONHandler: NSObject {
    
    static let sharedInstance = JSONHandler()
    
    private override init() {}
    
    func doGetRequest(completion: @escaping (PokemonObject?)->Void) {
        let getURL = URL(string: "https://api.pokemontcg.io/v1/cards")!
        
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        getRequest.httpMethod = "GET"
        
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if error != nil { print ("GET Request error!") }
            if data != nil {
                do {
                    let random = Int.random(in: 1...100)
                    let resultObject = try JSONDecoder().decode(Card.self, from: data!)
                    self.getImageCard(link: resultObject.cards[random].imageUrlHiRes, completion: { (sprite) in
                        completion(PokemonObject(newName: resultObject.cards[random].name, newImage: sprite, favoriteStatus: false))
                    })
                } catch {
                    DispatchQueue.main.async {
                        print("JSON Request Error!")
                    }
                }
            } else {
                print("Empty GetRequest")
            }
        }
        DispatchQueue.main.async {
            getTask.resume()
        }
    }
    
    func getImageCard(link: String, completion: @escaping(UIImage)->Void) {
        let getURL = URL(string: link)!
        
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
        getRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if let error = error {
                print("Request Error", error)
            }
            if let spriteData = data {
                completion(UIImage(data: spriteData) ?? UIImage())
            } else {
                print("Dont receive the image")
                completion(UIImage())
            }
        }
        DispatchQueue.main.async {
            dataTask.resume()
        }
    }
}


