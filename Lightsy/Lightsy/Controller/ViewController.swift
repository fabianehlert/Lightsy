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
    fileprivate var infoButton: UIButton?
    fileprivate var infoButtonVisible = true
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.lightView?.frame = self.view.frame
        self.infoButton?.center = infoButtonCenter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: UI
    
    fileprivate func setupUI() {
        self.lightView = LightView(frame: self.view.frame)
        self.lightView?.delegate = self
        if let l = self.lightView { self.view.addSubview(l) }

        self.infoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 33, height: 33))
        self.infoButton?.center = infoButtonCenter()
        self.infoButton?.addTarget(self, action: #selector(showCopyright), for: .touchUpInside)
        self.infoButton?.setImage(#imageLiteral(resourceName: "Info"), for: .normal)
        if let b = self.infoButton { self.view.addSubview(b) }
    }

    func showCopyright() {
        self.performSegue(withIdentifier: Segue.showCopyright.rawValue, sender: self)
    }
    
    fileprivate func infoButtonCenter() -> CGPoint {
        return CGPoint(x: self.view.center.x, y: self.view.frame.height - 60)
    }
}

extension ViewController: LightViewDelegate {
    func didInteract() {
        if infoButtonVisible {
            infoButtonVisible = false
            UIView.animate(withDuration: 0.3, animations: {
                self.infoButton?.alpha = 0.0
                }, completion: { completed in
                    self.infoButton?.removeFromSuperview()
            })
        }
    }
}
