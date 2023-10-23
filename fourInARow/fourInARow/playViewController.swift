//
//  playViewController.swift
//  fourInARow
//
//  Created by Ben Lou on 6/1/2018.
//  Copyright © 2018 Ben Lou. All rights reserved.
//

import UIKit

class playViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var turnColour: UIView!
    @IBOutlet weak var turn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isHidden = true
        turnColour.backgroundColor = nil
        turn.text? = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        stopButton.isHidden = false
        stopButton.layer.cornerRadius = stopButton.frame.height/2
        turnColour.layer.cornerRadius = turnColour.frame.height/2
        turnColour.backgroundColor = UIColor.red
        turn.text? = "RED\n"
        
        if resumeGame {
            turn.text = UserDefaults.standard.string(forKey: "turn")
            turnColour.backgroundColor = UserDefaults.standard.color(forKey: "turnColour")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7*6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        if resumeGame {
            cell.backgroundColor = (UserDefaults.standard.color(forKey: "colourCircles\(indexPath.item)"))
        } else {
            cell.backgroundColor = UIColor.lightGray
            for i in 0...41 {
                UserDefaults.standard.set(nil, forKey: "colourCircles\(i)")
            }
            UserDefaults.standard.set(nil, forKey: "turn")
            UserDefaults.standard.set(nil, forKey: "turnColour")
        }
        cell.layer.cornerRadius = cell.frame.height/2
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var outOfBounds = false
        var cell = collectionView.cellForItem(at: [0, indexPath.item%7+35])
        
        if cell?.backgroundColor != UIColor.lightGray {
            cell = collectionView.cellForItem(at: [0, indexPath.item%7+28])
            if cell?.backgroundColor != UIColor.lightGray {
                cell = collectionView.cellForItem(at: [0, indexPath.item%7+21])
                if cell?.backgroundColor != UIColor.lightGray {
                    cell = collectionView.cellForItem(at: [0, indexPath.item%7+14])
                    if cell?.backgroundColor != UIColor.lightGray {
                        cell = collectionView.cellForItem(at: [0, indexPath.item%7+7])
                        if cell?.backgroundColor != UIColor.lightGray {
                            cell = collectionView.cellForItem(at: [0, indexPath.item%7])
                            if cell?.backgroundColor != UIColor.lightGray {
                                outOfBounds = true
                            }
                        }
                    }
                }
            }
        }
        
        if !outOfBounds && turn.text != "YEL-LOW HAS WON!" && turn.text != "RED HAS WON!" {
            if turnColour.backgroundColor == UIColor.red {
                cell?.backgroundColor = turnColour.backgroundColor
                turnColour.backgroundColor = UIColor.yellow
                turn.text = "YEL-LOW"
            } else if turnColour.backgroundColor == UIColor.yellow {
                cell?.backgroundColor = turnColour.backgroundColor
                turnColour.backgroundColor = UIColor.red
                turn.text = "RED\n"
            }
        }
        
        var checkArr = [UIColor]()
        for i in 0...41 {
            checkArr += [(collectionView.cellForItem(at: [0, i])?.backgroundColor!)!]
            UserDefaults.standard.set((collectionView.cellForItem(at: [0, i])?.backgroundColor!)!, forKey: "colourCircles\(i)")
        }
        
        UserDefaults.standard.set(turn.text, forKey: "turn")
        UserDefaults.standard.set(turnColour.backgroundColor!, forKey: "turnColour")
        
        if !checkArr.contains(UIColor.lightGray) {
            turn.text = "DR-AW!"
            turnColour.backgroundColor = UIColor.lightGray
        }
        
        for i in 0..<checkArr.count {
            if i%7 != 4 && i%7 != 5 && i%7 != 6 {
                if checkArr[i] == checkArr[i+1] && checkArr[i+1] == checkArr[i+2] && checkArr[i+2] == checkArr[i+3] && checkArr[i] != UIColor.lightGray {
                    if turn.text == "RED\n" {
                        turn.text = "YEL-LOW HAS WON!"
                        turnColour.backgroundColor = UIColor.yellow
                    } else if turn.text == "YEL-LOW" {
                        turn.text = "RED HAS WON!"
                        turnColour.backgroundColor = UIColor.red
                    }
                    for i in 0...41 {
                        UserDefaults.standard.set(nil, forKey: "colourCircles\(i)")
                    }
                    UserDefaults.standard.set(nil, forKey: "turn")
                    UserDefaults.standard.set(nil, forKey: "turnColour")
                }
            }
            if i < 21 {
                if checkArr[i] == checkArr[i+7] && checkArr[i+7] == checkArr[i+14] && checkArr[i+14] == checkArr[i+21] && checkArr[i] != UIColor.lightGray {
                    if turn.text == "RED\n" {
                        turn.text = "YEL-LOW HAS WON!"
                        turnColour.backgroundColor = UIColor.yellow
                    } else if turn.text == "YEL-LOW" {
                        turn.text = "RED HAS WON!"
                        turnColour.backgroundColor = UIColor.red
                    }
                    for i in 0...41 {
                        UserDefaults.standard.set(nil, forKey: "colourCircles\(i)")
                    }
                    UserDefaults.standard.set(nil, forKey: "turn")
                    UserDefaults.standard.set(nil, forKey: "turnColour")
                }
            }
            if i%7 != 4 && i%7 != 5 && i%7 != 6 && i < 21 {
                if checkArr[i] == checkArr[i+8] && checkArr[i+8] == checkArr[i+16] && checkArr[i+16] == checkArr[i+24] && checkArr[i] != UIColor.lightGray {
                    if turn.text == "RED\n" {
                        turn.text = "YEL-LOW HAS WON!"
                        turnColour.backgroundColor = UIColor.yellow
                    } else if turn.text == "YEL-LOW" {
                        turn.text = "RED HAS WON!"
                        turnColour.backgroundColor = UIColor.red
                    }
                    for i in 0...41 {
                        UserDefaults.standard.set(nil, forKey: "colourCircles\(i)")
                    }
                    UserDefaults.standard.set(nil, forKey: "turn")
                    UserDefaults.standard.set(nil, forKey: "turnColour")
                }
            }
            if i%7 != 0 && i%7 != 1 && i%7 != 2 && i < 21 {
                if checkArr[i] == checkArr[i+6] && checkArr[i+6] == checkArr[i+12] && checkArr[i+12] == checkArr[i+18] && checkArr[i] != UIColor.lightGray {
                    if turn.text == "RED\n" {
                        turn.text = "YEL-LOW HAS WON!"
                        turnColour.backgroundColor = UIColor.yellow
                    } else if turn.text == "YEL-LOW" {
                        turn.text = "RED HAS WON!"
                        turnColour.backgroundColor = UIColor.red
                    }
                    for i in 0...41 {
                        UserDefaults.standard.set(nil, forKey: "colourCircles\(i)")
                    }
                    UserDefaults.standard.set(nil, forKey: "turn")
                    UserDefaults.standard.set(nil, forKey: "turnColour")
                }
            }
        }
    }
    
}

extension UserDefaults {
    func set(_ color: UIColor, forKey key: String) {
        set(NSKeyedArchiver.archivedData(withRootObject: color), forKey: key)
    }
    func color(forKey key: String) -> UIColor? {
        guard let data = data(forKey: key) else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
    }
}
