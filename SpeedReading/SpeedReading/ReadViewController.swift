//
//  ReadViewController.swift
//  SpeedReading
//
//  Created by Ben Lou on 15/2/2020.
//  Copyright © 2020 Ben Lou. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    
    @IBOutlet var word: UILabel!
    
    @IBOutlet var speedLabel: UILabel!
    
    let wordArray = readText.replacingOccurrences(of: "\n", with: " ").components(separatedBy: " ")
    var wordIndex = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        word.textColor = .red
        word.text = "Ready?"
        
        timer = Timer.scheduledTimer(timeInterval: 60/Double(slider.value), target: self, selector: #selector(changeWord), userInfo: nil, repeats: true)
        
        speedLabel.text = "\(Int(slider.value)) WPM"
        
        let playPauseButton = UIButton()
        playPauseButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 200)
        playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        playPauseButton.isEnabled = true
        self.view.addSubview(playPauseButton)
        
        
    }
    
    @objc func changeWord() {
        if wordIndex >= wordArray.count {
            word.textColor = .red
            word.text = "Congrats! You've finished!"
        } else {
            word.textColor = .white
            word.text = wordArray[wordIndex]
            if !stopped {
                wordIndex += 1
            }
        }
    }
    
    var stopped = false
    @objc func playPause() {
        stopped = !stopped
    }
    
    @IBAction func sliderDidChangeValue(_ sender: Any) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 60/Double(slider.value), target: self, selector: #selector(changeWord), userInfo: nil, repeats: true)
        
        speedLabel.text = "\(Int(slider.value)) WPM"
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
