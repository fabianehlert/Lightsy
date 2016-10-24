//
//  ViewController.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 22.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var lightView: LightView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lightView = LightView(frame: self.view.frame)
        if let l = self.lightView { self.view.addSubview(l) }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.lightView?.frame = self.view.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
