//
//  homeViewController.swift
//  fourInARow
//
//  Created by Ben Lou on 7/1/2018.
//  Copyright © 2018 Ben Lou. All rights reserved.
//

import UIKit

var resumeGame = Bool()

class homeViewController: UIViewController {

    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var resume: UIButton!
    
    @IBAction func newGame(_ sender: Any) {
        resumeGame = false
    }
    @IBAction func resume(_ sender: Any) {
        resumeGame = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newGame.layer.cornerRadius = newGame.frame.height/2
        resume.layer.cornerRadius = resume.frame.height/2
        
        if UserDefaults.standard.object(forKey: "colourCircles0") == nil {
            resume.isEnabled = false
            resume.backgroundColor = UIColor.lightGray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
