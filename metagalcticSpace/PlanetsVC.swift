//
//  PlanetsVC.swift
//  metagalcticSpace
//
//  Created by Hamza on 2/13/22.
//  Copyright © 2022 Hamza. All rights reserved.
//

import UIKit

class PlanetsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   
    

    @IBOutlet weak var tableView: UITableView!
    var planets = ["sun", "mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus",
                   "neptune", "moon"]
    
    var planetToPass: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "planetsCell", for: indexPath) as? PlanetsCell {
            cell.configCell(planetName: planets[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        planetToPass = planets[indexPath.row]
        performSegue(withIdentifier: "toPlanet", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.planet = planetToPass
        }
    }
}
