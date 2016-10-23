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

    lazy var tapRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle(tap:)))
        return tap
    }()
    
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
        self.addGestureRecognizer(self.tapRecognizer)
        self.addGestureRecognizer(self.panRecognizer)
        
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
    
    /// Handle tap gesture
    func handle(tap: UITapGestureRecognizer) {
        guard let colorProgress = self.color?.progress else { return }
        let location = tap.location(in: self)
        
        if location.y < (self.frame.height/2) {
            // upper half
            self.animate(progress: colorProgress + 0.12)
        } else {
            // lower half
            self.animate(progress: colorProgress - 0.12)
        }
    }
    
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
    
}

extension LightView {
    /// Call continuously to update the progress of animations
    func update(progress: CGFloat) {
        self.color?.progress = progress
    }
    
    /// Call to animate jump to a specific progress point.
    func animate(progress: CGFloat, duration: CGFloat = 0.6) {
        self.color?.animate(progress, duration: duration)
    }
}
