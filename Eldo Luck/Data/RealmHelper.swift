//
//  RealmHelper.swift
//  Eldo Luck
//
//  Created by Анастасия on 15.05.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    private let realm = try! Realm()
    
    func writeData(data: String) {
        let quote = Quote()
        quote.id = UUID().uuidString
        quote.text = data
        
        try! realm.write() {
            realm.add(quote)
        }
    }
    
    func removeDataAt(id: String) {
        if let itemForRemove = getData().filter({$0.id == id}).first {
            try! realm.write {
                realm.delete(itemForRemove)
            }
        }
    }
    
    func addFirstData() {
        if UserDefaults.standard.value(forKey: "firstLoad") == nil {
            let data = ["first",
                        "Hug the first passer-by of each age",
                        "Call any person from your contacts and make an ABC Challenge",
                        "Say a beautiful Caucasian toast",
                        "Become a model for an obscene photo session with a soft toy",
                        "Picture with your own figure some familiar picture",
                        "Walk as a model on the podium",
                        "Imagine an airplane and ride it for everyone",
                        "Give anything to any player you like",
                        "Compose a ditty about tonight.",
                        "Wear something unusual and wear it till the end of the game",
                        "Come up with a profession for each player, which begins with the first letter of his name",
                        "Do a barrel roll",
                        "Make a bottle flip",
                        "Take a shower without taking off your clothes.",
                        "Play anything another player tells you for a few minutes",
                        "Take off one piece of clothing",
                        "Knock on the neighbour's door. When someone opens the door to kiss him or her on both cheeks",
                        "Pick a player of the opposite sex to shower with you",
                        "Do an Indian combat coloring on your face",
                        "Pretend you've been hit by a bullet and you're falling from a wound",
                        "Say any patter you're told, no stuttering",
                        "A passionate kiss from the opposite sex in our company",
                        "Put your clothes inside out and stay like this until the end of the gam",
                        "Parody your best friend",
                        "Swap any item of clothing with a person sitting next to you",
                        "Picture anything another player tells you for a few minutes"]
            
            for i in data {
                writeData(data: i)
            }
            
            UserDefaults.standard.set(false, forKey: "firstLoad")
        }
    }
    
    func getData() -> [Quote] {
        let results = realm.objects(Quote.self)
        return results.toArray(ofType: Quote.self).reversed()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
