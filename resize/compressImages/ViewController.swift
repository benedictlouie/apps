//
//  ViewController.swift
//  compressImage
//
//  Created by Ben Lou on 10/7/2019.
//  Copyright © 2019 Ben Lou. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imageView = UIImageView()
    let importButton = UIButton()
    let shareButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.backgroundColor = .gray
        imageView.frame.size.width = self.view.frame.width
        self.view.addSubview(imageView)
        
        importButton.frame = CGRect(x: 0, y: self.view.frame.height-160, width: 250, height: 50)
        importButton.center.x = self.view.center.x
        importButton.layer.cornerRadius = importButton.frame.height/2
        importButton.backgroundColor = UIColor(red: 48/255, green: 103/255, blue: 232/255, alpha: 1)
        importButton.setTitleColor(.white, for: .normal)
        importButton.setTitle(" Import Image ", for: .normal)
        importButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        self.view.addSubview(importButton)
        
        shareButton.frame = CGRect(x: 0, y: self.view.frame.height-100, width: 250, height: 50)
        shareButton.center.x = self.view.center.x
        shareButton.layer.cornerRadius = importButton.frame.height/2
        shareButton.backgroundColor = UIColor(red: 228/255, green: 123/255, blue: 77/255, alpha: 1)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.setTitle(" Share resized images ", for: .normal)
        shareButton.addTarget(self, action: #selector(shareImages), for: .touchUpInside)
        self.view.addSubview(shareButton)
        
    }
    
    var imagePicker = UIImagePickerController()
    
    @objc func pickImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let loading = UILabel()
            loading.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            loading.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
            loading.textAlignment = .center
            loading.textColor = .white
            loading.text = "Preparing..."
            self.view.addSubview(loading)
            
            DispatchQueue.main.async {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: {
                    loading.removeFromSuperview()
                })
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = image
            self.imageView.frame.size.height = self.view.frame.width * image.size.height / image.size.width
            self.imageView.center = self.view.center
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareImages() {
        
        let loading = UILabel()
        loading.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        loading.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
        loading.textAlignment = .center
        loading.textColor = .white
        loading.text = "Preparing..."
        self.view.addSubview(loading)
        
        DispatchQueue.main.async {
            
            var imageArray = [UIImage]()
            if let image = self.imageView.image {
                for size in [40, 60, 58, 87, 80, 120, 120, 180, 20, 40, 29, 58, 40, 80, 76, 152, 167, 1024] {
                    imageArray.append(image.resized(toWidth: CGFloat(integerLiteral: size))!)
                }
            }
            
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: imageArray, applicationActivities: nil)
            
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            activityViewController.excludedActivityTypes = []
            
            self.present(activityViewController, animated: true, completion: {
                loading.removeFromSuperview()
            })
            
        }
    }
    
}


extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
