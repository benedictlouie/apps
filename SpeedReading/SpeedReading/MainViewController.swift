//
//  MainViewController.swift
//  SpeedReading
//
//  Created by Ben Lou on 15/2/2020.
//  Copyright © 2020 Ben Lou. All rights reserved.
//

import UIKit

var readText = ""

class MainViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textView: UITextView!
    
    let doneButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        doneButton.frame = CGRect(x: self.view.frame.width - 88, y: 40, width: 80, height: 40)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        doneButton.isUserInteractionEnabled = true
        doneButton.isEnabled = true
        self.view.addSubview(doneButton)
        doneButton.isHidden = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        doneButton.isHidden = false
    }
    
    @objc func done() {
        textView.resignFirstResponder()
        doneButton.isHidden = true
    }
    
    @IBAction func start(_ sender: Any) {
        readText = textView.text
        performSegue(withIdentifier: "Start Segue", sender: self)
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
