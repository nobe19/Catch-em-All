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
        
        var creatureDetails = CreatureDetails()
        creatureDetails.urlString = creature.url
        creatureDetails.getData {
            DispatchQueue.main.async {
                self.heightLabel.text = "\(creatureDetails.height)"
                self.weightLabel.text = "\(creatureDetails.weight)"
                
                guard let url = URL(string: creatureDetails.imageURL) else {return}
                do {
                    let data = try Data(contentsOf: url)
                    self.imageView.image = UIImage(data: data)
                } catch {
                    print("😡 ERROR: Could not get image from url \(url), \(error.localizedDescription)")
                }
            }
        }
    }
}
