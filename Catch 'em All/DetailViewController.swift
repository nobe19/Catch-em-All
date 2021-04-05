//
//  DetailViewController.swift
//  Catch 'em All
//
//  Created by Nipuni Obe on 4/5/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    var creature: Creature!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if creature == nil {
            creature = Creature(name: "", url: "")
        }
        
        nameLabel.text = creature.name.capitalized
        heightLabel.text = ""
        weightLabel.text = ""
    }
}
