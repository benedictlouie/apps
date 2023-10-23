//
//  ViewController.swift
//  Running
//
//  Created by Ben Lou on 10/1/2020.
//

import UIKit

class GameViewController: UIViewController {

    
    let runLength = 10_000
    let blockHeight = 100
    let startFactor: CGFloat = 1.5
    let holeInterval = 360
    let holeWidth = 120
    let guyHeight = 280
    let jumpHeight = 100
    let jumpTime = 0.15
    let randomConstant = 80
    let frameRate = 0.03
    
    let block = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        let frameMovement = frameRate*1000
        
        self.view.backgroundColor = .systemBlue
        
        block.frame = CGRect(x: 0, y: Int(screenHeight)-blockHeight, width: runLength, height: blockHeight)
        block.backgroundColor = .lightGray
        self.view.addSubview(block)
        
        var holes = [Int]()
        for i in Int(screenWidth*startFactor)...runLength-Int(screenWidth*startFactor) {
            holes.append(i)
        }
        holes.shuffle()
        for _ in runLength/holeInterval..<holes.count {
            holes.removeLast()
        }
        holes.sort()
        var j = 1
        while j < holes.count {
            if holes[j] - holes[j-1] < holeInterval {
                holes.remove(at: j)
            } else {
                j += 1
            }
        }
        
        for x in holes {
            let hole = UIView()
            hole.frame = CGRect(x: x, y: 0, width: holeWidth, height: 100)
            hole.backgroundColor = .systemBlue
            block.addSubview(hole)
        }
        
        var lose = false
        
        var timer: Timer?
        
        timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { _ in
            
            // win
            if self.block.frame.origin.x > 0 - CGFloat(self.runLength) + screenWidth + CGFloat(self.randomConstant) && !lose {
                
                self.block.frame.origin.x -= CGFloat(frameMovement)
                
                for x in holes {
                    let upperBound = 0 - (CGFloat(x) - screenWidth / 3 + 10)
                    let lowerBound = 0 - (CGFloat(x) - screenWidth / 3 + 50)
                    
                    
                    // fall
                    if self.block.frame.origin.x <= upperBound && self.block.frame.origin.x > lowerBound && self.guy.frame.origin.y + CGFloat(self.guyHeight) >= screenHeight - CGFloat(self.blockHeight) {
                        
                        lose = true
                        self.guy.frame = CGRect(x: Int(screenWidth / 3) + Int(frameMovement), y: Int(screenHeight) - self.guyHeight + self.randomConstant, width: 50, height: 100)
                        self.guy.image = UIImage(named: "guy-fall")
                        self.button.isEnabled = false
                        UIView.animate(withDuration: 1, animations: {
                            self.guy.frame.origin.y += 500
                        }) { _ in
                            timer?.invalidate()
                            self.restart()
                        }
                        
                    }
                }
                
                
            } else {
                timer?.invalidate()
                self.button.isEnabled = false
                if !lose {
                    UIView.animate(withDuration: 2, animations: {
                        self.guy.frame.origin.x += screenWidth * 2/3
                    }) { _ in
                        self.restart()
                    }
                }
            }
        }
        
        guy.loadGif(name: "guy")
        guy.frame = CGRect(x: Int(screenWidth)/3, y: Int(screenHeight)-guyHeight-randomConstant/2, width: guyHeight-randomConstant, height: guyHeight)
        guy.contentMode = .scaleAspectFit
        self.view.addSubview(guy)
        
        button.frame = self.view.frame
        button.alpha = 0.4
        button.addTarget(self, action: #selector(jump), for: .touchDown)
        self.view.addSubview(button)
        
        
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(restart))
//        swipeLeft.direction = .left
//        self.view.addGestureRecognizer(swipeLeft)
    }
    
    let guy = UIImageView()
    let button = UIButton()
    
    @objc func jump() {
        button.isEnabled = false
        UIView.animate(withDuration: self.jumpTime, animations: {
            self.guy.frame.origin.y -= CGFloat(self.jumpHeight)
            self.block.frame.origin.x -= CGFloat(self.randomConstant/2)
        }) { _ in
            UIView.animate(withDuration: self.jumpTime, animations: {
                self.guy.frame.origin.y += CGFloat(self.jumpHeight)
            }) {_ in
                self.button.isEnabled = true
            }
        }
    }
    @objc func restart() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.performSegue(withIdentifier: "home", sender: self)
        }
        
    }


}

