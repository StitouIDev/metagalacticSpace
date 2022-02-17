//
//  PlanetsCell.swift
//  metagalcticSpace
//
//  Created by Hamza on 2/13/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit

class PlanetsCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configCell(planetName: String) {
        img.image = UIImage(named: planetName)
        name.text = planetName
    }

}
