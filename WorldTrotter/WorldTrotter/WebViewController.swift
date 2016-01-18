//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by lynn on 16/1/17.
//  Copyright © 2016年 green. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var containerView : UIView! = nil
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        self.webView = WKWebView()
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string:"https://www.bignerdranch.com/")
        let req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
    }
}
