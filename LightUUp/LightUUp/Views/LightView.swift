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

    
    // MARK: Setup
    
    func setupUI() {
        self.addGestureRecognizer(panRecognizer)
        
        let colors = Light.all.flatMap { (light) -> UIColor? in
            return light.color
        }
        
        self.color = Interpolate(values: colors, apply: {
            [weak self] (color) in
            self?.backgroundColor = color
        })
        self.update(progress: 0.0)
    }
    
}

extension LightView {
    
    /// Handle pan gesture
    func handle(pan: UIPanGestureRecognizer) {
        // let location = pan.location(in: self)
        let translation = pan.translation(in: self)
        
        switch pan.state {
        case .began:
            break
        case .changed:
            self.update(progress: (fabs(translation.y)/500.0))
        case .ended:
            break

        default:
            break
        }
    }
    
    /// Call continuously to update the progress of animations
    func update(progress: CGFloat) {
        self.color?.progress = progress
    }
    
    /// Call to animate jump to a specific progress point.
    func animate(progress: CGFloat, duration: CGFloat = 0.2) {
        self.color?.animate(progress, duration: duration)
    }
    
}
