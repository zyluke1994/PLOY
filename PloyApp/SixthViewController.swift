//
//  SixthViewController.swift
//  Project3_Alex_Mai
//
//  Created by Alex Mai on 12/11/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import Foundation
import UIKit

class SixthViewController: UIViewController {
    
    var url: String!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlSubmit = URL(string: url) {
            let request = URLRequest(url: urlSubmit)
            webView.loadRequest(request)
        }
        else {
            print("Invalid URL")
        }
        
    }
    
}
