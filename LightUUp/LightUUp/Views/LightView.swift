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
        self.goTo(progress: 0.0, duration: 0.0)
    }
    
}

extension LightView {
    
    /// Handle tap gesture
    func handle(tap: UITapGestureRecognizer) {
        let location = tap.location(in: self)
        
        if location.y < (self.frame.height/2) {
            // upper half
            self.updateProgress(delta: 0.12, animated: true)
        } else {
            // lower half
            self.updateProgress(delta: -0.12, animated: true)
        }
    }
    
    /// Handle pan gesture
    func handle(pan: UIPanGestureRecognizer) {
        // let location = pan.location(in: self)
        // let translation = pan.translation(in: self)
        let velocity = pan.velocity(in: self)
        print("velocity: \(velocity.y)")
        let positive = velocity.y > 0
        
        switch pan.state {
        case .began:
            break
        case .changed:
            // self.goTo(progress: (fabs(translation.y)/500.0), duration: 0.0)
            self.updateProgress(delta: positive ? -0.01 : 0.01)
        case .ended:
            break

        default:
            break
        }
    }
    
}

extension LightView {
    /// Update progress by given delta.
    func updateProgress(delta: CGFloat, animated: Bool = false) {
        guard let progress = self.color?.progress else { return }
        self.goTo(progress: progress + delta, duration: animated ? 0.7 : 0.0)
    }
    
    /// Go to specific progress position.
    func goTo(progress: CGFloat, duration: CGFloat = 0.7) {
        let p = progress.fitTo(range: 0.0...1.0)
        
        if duration != 0.0 {
            self.color?.animate(p, duration: duration)
        } else {
            self.color?.progress = p
        }
    }
}

extension CGFloat {
    func fitTo(range: ClosedRange<CGFloat>) -> CGFloat {
        if range ~= self { return self }
        return [range.lowerBound, range.upperBound].enumerated().min(by: { abs($0.1 - self) < abs($1.1 - self) })?.element ?? 0.0
    }
}
