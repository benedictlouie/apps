//
//  LearnViewController.swift
//  Running
//
//  Created by Ben Lou on 20/1/2020.
//

import UIKit
import WebKit

class LearnViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.frame = CGRect(x: 0, y: 50, width: self.view.frame.height * 4/3, height: self.view.frame.height - 58)
        webView.center.x = self.view.frame.width / 2
        webView.isUserInteractionEnabled = false
        self.view.addSubview(webView)
        
        
        if let myURL = URL(string: "https://cdn.kastatic.org/googleusercontent/1Rg-Qta5_pZl6FoYNrBU8t5hIwXqcTucLVm2cWc8nZ-QE08qv9G-5f0rYIgkiAVUMElY_ZKBkppTvu0jGPmPWr28") {
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
        
        
    }

}
