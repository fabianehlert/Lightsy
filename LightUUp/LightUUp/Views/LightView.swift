//
//  LightView.swift
//  LightUUp
//
//  Created by Fabian Ehlert on 23.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit
import Interpolate

class LightView: UIView {

    lazy var panRecognizer: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handle(pan:)))
        return pan
    }()
    
    // MARK: Animations
    
    var color: Interpolate?
    
    
    // MARK: View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: Setup
    
    func setupUI() {
        self.addGestureRecognizer(panRecognizer)
        
        color = Interpolate(from: UIColor.black, to: UIColor.white, apply: {
            [weak self] (color) in
            self?.backgroundColor = color
        })
    }
    
}

extension LightView {
    
    /// Handle pan gesture
    func handle(pan: UIPanGestureRecognizer) {
        // let location = pan.location(in: self)
        // let translation = pan.translation(in: self)
        
        switch pan.state {
        case .began:
            print("Began")
        case .changed:
            print("Changed")
        case .ended:
            print("Ended")

        default:
            break
        }
    }
    
    /// Call continuously to update the progress of animations
    func update(progress: CGFloat) {
        
    }
    
    /// Call to animate jump to a specific progress point.
    func animate(progress: CGFloat, duration: CGFloat = 0.2) {
        
    }
}
