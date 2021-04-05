//
//  ListViewController.swift
//  Catch 'em All
//
//  Created by Nipuni Obe on 4/5/21.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //    var creatures = ["Bulbasaur", "Pikachu", "Snorlax", "Wigglypuff", "Charmander"]
    
    var creatures: Creatures!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        creatures = Creatures()
        creatures.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "Returned \(self.creatures.creatureArray.count) of \(self.creatures.count)"
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.creature = creatures.creatureArray[selectedIndexPath.row]
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatures.creatureArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(creatures.creatureArray[indexPath.row].name)"
        return cell
    }
}


