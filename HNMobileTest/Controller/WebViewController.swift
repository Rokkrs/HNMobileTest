//
//  WebViewController.swift
//  HNMobileTest
//
//  Created by Oscar Cuadra on 1/26/18.
//  Copyright © 2018 Oscar Cuadra. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    var hits : Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        let url = URL(string: (self.hits?.story_url)!)
        if url != nil {
            let request = URLRequest(url: url!)
            self.webView.load(request)
        }

    }

}
