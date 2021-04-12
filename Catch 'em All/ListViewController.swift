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
    var loadAllCallCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        creatures = Creatures()
        self.showIndicator(onView: self.view)
        loadData(loadAll: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.creature = creatures.creatureArray[selectedIndexPath.row]
        }
    }
    
    func loadData(loadAll: Bool) {
        loadAllCallCount += 1
        print("***loadAllCallCount = \(loadAllCallCount)")
        if creatures.urlString.hasPrefix("http") {
            creatures.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Returned \(self.creatures.creatureArray.count) of \(self.creatures.count)"
                    self.tableView.reloadData()
                    if loadAll {
                        self.loadData(loadAll: loadAll)
                    } else {
                        self.removeIndicator()
                    }
                }
            }
        } else {
            self.removeIndicator()
        }
    }
    
    @IBAction func loadAllPressed(_ sender: UIBarButtonItem) {
        loadData(loadAll: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creatures.creatureArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        print("indexPath.row = \(indexPath.row) creatures.creatureArray.count-1 = \(creatures.creatureArray.count-1)")
        cell.textLabel?.text = "\(indexPath.row + 1). \(creatures.creatureArray[indexPath.row].name.capitalized)"
        if (indexPath.row == creatures.creatureArray.count - 1) && (creatures.urlString.hasPrefix("http")) {
            self.showIndicator(onView: self.view)
            loadData(loadAll: false)
        }
        return cell
    }
}


