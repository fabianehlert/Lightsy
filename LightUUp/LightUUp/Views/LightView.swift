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

    // MARK: Gestures
    
    var lastLocation = CGPoint.zero
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle(tap:)))
        return tap
    }()
    
    lazy var panRecognizer: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handle(pan:)))
        return pan
    }()
    
    
    // MARK: UI Elements
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 66, weight: UIFontWeightThin)
        return label
    }()
    
    // MARK: Animations
    
    var color: Interpolate?
    var temperature: Interpolate?
    
    
    // MARK: View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }

    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.setupTemperatureLabel()
    }
    
    // MARK: Setup
    
    func setupUI() {
        self.addGestureRecognizer(self.tapRecognizer)
        self.addGestureRecognizer(self.panRecognizer)
        
        self.setupInterpolate()

        self.addSubview(self.temperatureLabel)
        self.hideTemperature(delay: 2.0)
    }
    
    func setupInterpolate() {
        let colors = Light.all.flatMap { (light) -> UIColor? in
            return light.color
        }

        self.color = Interpolate(values: colors, apply: {
            [weak self] (color) in
            self?.backgroundColor = color
        })
        
        let temps = Light.all.flatMap { (light) -> Int? in
            return light.kelvin
        }
        
        self.temperature = Interpolate(values: temps, apply: {
            [weak self] (temp) in
            self?.temperatureLabel.pushTransition(duration: 0.1)
            self?.temperatureLabel.text = "\(temp)K"
        })

        self.goTo(progress: 0.0, duration: 0.0)
    }
    
    
    // MARK: Temperature label
    
    func setupTemperatureLabel() {
        self.temperatureLabel.frame = CGRect(x: 60, y: 60, width: 300, height: 80)
        self.temperatureLabel.center = CGPoint(x: self.center.x, y: 80)
        self.temperatureLabel.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
    }

    func showTemperature(delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: 0.3, delay: delay, options: [.curveEaseOut], animations: {
            self.temperatureLabel.alpha = 1.0
            }, completion: nil)
    }

    func hideTemperature(delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: 0.3, delay: delay, options: [.curveEaseOut], animations: {
            self.temperatureLabel.alpha = 0.0
        }, completion: nil)
    }
    
}

extension LightView {
    
    /// Handle tap gesture
    func handle(tap: UITapGestureRecognizer) {
        let location = tap.location(in: self)
        
        if location.y < (self.frame.height/2) {
            // upper half
            self.updateProgress(delta: -(1.0/CGFloat(Light.all.count)), animated: true)
        } else {
            // lower half
            self.updateProgress(delta: (1.0/CGFloat(Light.all.count)), animated: true)
        }
        
        self.showTemperature()
        self.hideTemperature(delay: 1.0)
    }
    
    /// Handle pan gesture
    func handle(pan: UIPanGestureRecognizer) {
        let location = pan.location(in: self)
        let deltaY = self.lastLocation.y - location.y
        self.lastLocation = location
        
        switch pan.state {
        case .began:
            self.showTemperature()
        case .changed:
            let d = -deltaY / 400
            self.updateProgress(delta: d)
        case .ended:
            self.hideTemperature(delay: 0.5)
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
            self.temperature?.animate(p, duration: duration)
        } else {
            self.color?.progress = p
            self.temperature?.progress = p
        }
    }
}

extension CGFloat {
    func fitTo(range: ClosedRange<CGFloat>) -> CGFloat {
        if range ~= self { return self }
        return [range.lowerBound, range.upperBound].enumerated().min(by: { abs($0.1 - self) < abs($1.1 - self) })?.element ?? 0.0
    }
}

// Usage: insert view.pushTransition right before changing content
// http://stackoverflow.com/questions/33632266/animate-text-change-of-uilabel
extension UIView {
    func pushTransition(duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionPush)
    }
}
