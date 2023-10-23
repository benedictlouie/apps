//
//  ProcessViewController.swift
//  ProcessImage
//
//  Created by Ben Lou on 19/3/2020.
//  Copyright © 2020 Ben Lou. All rights reserved.
//

import UIKit

class ProcessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if Double(Int((sqrt(Double(filter1.count))-1)/2.0)) != (sqrt(Double(filter1.count))-1)/2.0 {
            return
        }
        let span = Int((sqrt(Double(filter1.count))-1)/2.0)
        
        
        let start = Date()
        
        let iw = Int(loadImage.size.width)
        let ih = Int(loadImage.size.height)
        
        var y = 0
        var timer = Timer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.000001, repeats: true) { _ in
            if y < ih {
                for x in 0..<iw {
                    var color = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                    
                    
                    if x >= span && x < iw - span && y >= span && y < ih - span {
                        var finalR: CGFloat = 0, finalG: CGFloat = 0, finalB: CGFloat = 0, finalA: CGFloat = 0
                        var index = 0
                        for i in -span...span {
                            for j in -span...span {
                                finalR += loadImage.getPixelColor(pos: CGPoint(x: x+i, y: y+j)).rgba.red * filter1[index]
                                finalG += loadImage.getPixelColor(pos: CGPoint(x: x+i, y: y+j)).rgba.green * filter1[index]
                                finalB += loadImage.getPixelColor(pos: CGPoint(x: x+i, y: y+j)).rgba.blue * filter1[index]
                                finalA += loadImage.getPixelColor(pos: CGPoint(x: x+i, y: y+j)).rgba.alpha * filter1[index]
                                index += 1
                            }
                        }
                        color = UIColor(
                            red: finalR > 1 ? 1 : (finalR < 0 ? 0 : finalR),
                            green: finalG > 1 ? 1 : (finalG < 0 ? 0 : finalG),
                            blue: finalB > 1 ? 1 : (finalB < 0 ? 0 : finalB),
                            alpha: 1
                        )
                    }
                    
                    let pixelSize = 3
                    
                    let pix = UIView()
                    pix.backgroundColor = color
                    pix.frame = CGRect(
                        x: x * pixelSize + 20,
                        y: y * pixelSize + 20,
                        width: pixelSize,
                        height: pixelSize
                    )
                    self.view.addSubview(pix)
                }
                
                
                y += 1
            } else {
                timer.invalidate()
                print("done")
                print(Calendar.current.dateComponents([.second], from: start, to: Date()))
            }
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


extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
