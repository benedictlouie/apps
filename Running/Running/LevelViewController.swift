//
//  LevelViewController.swift
//  Running
//
//  Created by Ben Lou on 20/1/2020.
//

import UIKit

class LevelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let levels = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Level \(indexPath.row/2 + 1)"
        
        if indexPath.row%2 == 1 {
            cell.textLabel?.text! += " Learn"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row%2 == 0 {
            performSegue(withIdentifier: "game", sender: self)
        } else if indexPath.row%2 == 1 {
            performSegue(withIdentifier: "learn", sender: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
