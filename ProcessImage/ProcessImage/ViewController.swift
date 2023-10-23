//
//  ViewController.swift
//  ProcessImage
//
//  Created by Ben Lou on 18/3/2020.
//  Copyright © 2020 Ben Lou. All rights reserved.
//

import UIKit

var loadImage = UIImage()
var filter1 : [CGFloat] = [
    0, 0, 0,
    0, 1, 0,
    0, 0, 0
]

class ViewController: UIViewController {

    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        contentView.frame = self.view.frame
        contentView.frame.size.width = self.view.frame.width * 2
        contentView.isUserInteractionEnabled = true
        self.view.addSubview(contentView)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = self.view.frame
        guard let url = URL(string: "https://www.dbs.edu.hk/headeng.png") else { return }
        contentView.addSubview(imageView)
        
        let image = #imageLiteral(resourceName: "six")
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { return }
//            DispatchQueue.main.async() {
//                guard let image = UIImage(data: data) else { return }
                loadImage = image
                imageView.image = image
                
                let nextButton = UIButton()
                nextButton.backgroundColor = .systemBlue
                nextButton.setTitle("Next", for: .normal)
                nextButton.frame.origin.y = self.view.frame.height - 80
                nextButton.frame.size.width = 200
                nextButton.frame.size.height = 50
                nextButton.center.x = self.view.center.x
                nextButton.addTarget(self, action: #selector(self.setKernel), for: .touchUpInside)
                nextButton.layer.cornerRadius = 10
                contentView.addSubview(nextButton)
//            }
//        }.resume()
        
        let backButton = UIButton()
        backButton.frame = CGRect(
            x: 30 + self.view.frame.width,
            y: 30,
            width: 50,
            height: 50
        )
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Helvetica Bold", size: 50)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        contentView.addSubview(backButton)
        
        
        let processButton = UIButton()
        processButton.backgroundColor = .systemBlue
        processButton.setTitle("Process Image", for: .normal)
        processButton.frame.origin.y = self.view.frame.height - 80
        processButton.frame.size.width = 200
        processButton.frame.size.height = 50
        processButton.center.x = self.view.center.x + self.view.frame.width
        processButton.addTarget(self, action: #selector(self.process), for: .touchUpInside)
        processButton.layer.cornerRadius = 10
        contentView.addSubview(processButton)
        
        let table = UITableView()
        table.frame = CGRect(x: 8 + self.view.frame.width, y: 100, width: self.view.frame.width - 16, height: self.view.frame.height - 200)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.addSubview(table)
        
    }
    
    
    @objc func setKernel() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.frame.origin.x -= self.view.frame.width
            self.contentView.isUserInteractionEnabled = false
        }) { _ in
            self.contentView.isUserInteractionEnabled = true
        }
    }
    @objc func back() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.frame.origin.x += self.view.frame.width
            self.contentView.isUserInteractionEnabled = false
        }) { _ in
            self.contentView.isUserInteractionEnabled = true
        }
    }
    @objc func process() {
        performSegue(withIdentifier: "Process Segue", sender: self)
    }
    

}

let filters: [String: [CGFloat]] = [
    "Identity": [
        1
    ],
    "Box Blur": [
        1/9, 1/9, 1/9,
        1/9, 1/9, 1/9,
        1/9, 1/9, 1/9
    ],
    "Gaussian Blur 3x3": [
        1/16, 1/8, 1/16,
        1/8, 1/4, 1/8,
        1/16, 1/8, 1/16
    ],
    
    "Sharpen": [
        0, -1, 0,
        -1, 5, -1,
        0, -1, 0
    ],
    "Edge Detection 1": [
        1, 0, -1,
        0, 0, 0,
        -1, 0, 1
    ],
    "Edge Detection 2": [
        0, 1, 0,
        1, -4, 1,
        0, 1, 0
    ],
    "Edge Detection 3": [
        -1, -1, -1,
        -1, 8, -1,
        -1, -1, -1
    ],
    "Gaussian Blur 5x5": [
        1/256, 4/256, 6/256, 4/256, 1/256,
        4/256, 16/256, 24/256, 16/256, 4/256,
        6/256, 24/256, 36/256, 24/256, 6/256,
        4/256, 16/256, 24/256, 16/256, 4/256,
        1/256, 4/256, 6/256, 4/256, 1/256
    ],
    "Unsharp Masking 5x5": [
        -1/256, -4/256, -6/256, -4/256, -1/256,
        -4/256, -16/256, -24/256, -16/256, -4/256,
        -6/256, -24/256, 476/256, -24/256, -6/256,
        -4/256, -16/256, -24/256, -16/256, -4/256,
        -1/256, -4/256, -6/256, -4/256, -1/256
    ]
]


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Array(filters.keys)[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filter1 = Array(filters.values)[indexPath.row]
    }
    
    
    
    
}
