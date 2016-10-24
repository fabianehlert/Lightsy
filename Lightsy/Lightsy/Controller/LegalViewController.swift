//
//  LegalViewController.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 25.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {

    @IBOutlet fileprivate weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let legalURL = Bundle.main.url(forResource: "Legal", withExtension: "html") {
            self.webview.loadRequest(URLRequest(url: legalURL))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
