//
//  Creatures.swift
//  Catch 'em All
//
//  Created by Nipuni Obe on 4/5/21.
//

import Foundation

class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    var count = 0
    var creatureArray: [Creature] = []
    var isFetching = false
    
    func getData(completed: @escaping () -> ()) {
        guard isFetching == false else {
            print("*** Didn't call getData here, bc we hadn't fetched data")
            return
        }
        isFetching = true
        
        print("🕸 We are accessing the URL, \(urlString)")
        
        //create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
        
        //create session
        let session = URLSession.shared
        
        //get data w/ .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            //deal w/ data
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.count = returned.count
                self.urlString = returned.next ?? ""
                self.creatureArray = returned.results
                //print("😎 Here is what was returned: \(returned)")
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            self.isFetching = false
            completed()
        }
        task.resume()
    }
}
