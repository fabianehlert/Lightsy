//
//  LightView.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 23.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit
import Interpolate

protocol LightViewDelegate {
    /// LightView was touched
    func didInteract()
}

class LightView: UIView {

    // MARK: Delegate
    
    var delegate: LightViewDelegate?
    
    
    // MARK: Gestures
    
    fileprivate var guidePresent = false
    fileprivate var fingerImageView: UIImageView?
    fileprivate var lastLocation = CGPoint.zero
    
    fileprivate let tapRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle(tap:)))
        return tap
    }()
    
    fileprivate let panRecognizer: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handle(pan:)))
        return pan
    }()
    
    
    // MARK: UI Elements
    
    fileprivate let temperatureLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 66, weight: UIFontWeightThin)
        return label
    }()
    
    
    // MARK: Animations
    
    fileprivate var color: Interpolate?
    fileprivate var temperature: Interpolate?
    
    
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
        self.updateUI()
    }
    
    // MARK: Setup
    
    fileprivate func setupUI() {
        self.addGestureRecognizer(self.tapRecognizer)
        self.addGestureRecognizer(self.panRecognizer)
        
        self.setupInterpolate()
        self.setupTemperatureLabel()
        self.hideTemperature(delay: 2.0)
        
        self.displayGuideIfNeeded()
    }
    
    fileprivate func updateUI() {
        // Update UI elements here
    }
    
    fileprivate func setupInterpolate() {
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
            self?.temperatureLabel.fadeTransition(duration: 0.1)
            self?.temperatureLabel.text = "\(temp)K"
        })

        self.goTo(progress: 0.0, duration: 0.0)
    }
    
    
    // MARK: Temperature label
    
    fileprivate func setupTemperatureLabel() {
        self.temperatureLabel.frame = CGRect(x: 60, y: 60, width: 300, height: 80)
        self.temperatureLabel.center = CGPoint(x: self.center.x, y: 80)
        self.temperatureLabel.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        self.addSubview(self.temperatureLabel)
    }

    fileprivate func showTemperature(delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: 0.3, delay: delay, options: [.curveEaseOut], animations: {
            self.temperatureLabel.alpha = 1.0
            }, completion: nil)
    }

    fileprivate func hideTemperature(delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: 0.3, delay: delay, options: [.curveEaseOut], animations: {
            self.temperatureLabel.alpha = 0.0
        }, completion: nil)
    }
    
}

extension LightView {
    
    /// Handle tap gesture
    func handle(tap: UITapGestureRecognizer) {
        self.delegate?.didInteract()
        // Remove guide/finger animation
        self.dismissGuideIfPresent()
        
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
        self.delegate?.didInteract()
        // Remove guide/finger animation
        self.dismissGuideIfPresent()

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
    fileprivate func updateProgress(delta: CGFloat, animated: Bool = false) {
        guard let progress = self.color?.progress else { return }
        self.goTo(progress: progress + delta, duration: animated ? 0.7 : 0.0)
    }
    
    /// Go to specific progress position.
    fileprivate func goTo(progress: CGFloat, duration: CGFloat = 0.7) {
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

extension LightView {
    fileprivate func displayGuideIfNeeded() {
        if UserDefaults.standard.bool(forKey: Defaults.firstAppLaunch.rawValue) { return }

        self.guidePresent = true
        
        self.fingerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        guard let fingerImageView = self.fingerImageView else { return }
        fingerImageView.center = CGPoint(x: self.center.x, y: 200)
        fingerImageView.isUserInteractionEnabled = false
        fingerImageView.image = #imageLiteral(resourceName: "Finger")
        fingerImageView.backgroundColor = .clear
        fingerImageView.alpha = 1.0
        
        self.addSubview(fingerImageView)
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            fingerImageView.frame = fingerImageView.frame.offsetBy(dx: 0, dy: 250)
        }, completion: nil)
    }
    
    fileprivate func dismissGuideIfPresent() {
        if let fingerImageView = self.fingerImageView,
            self.guidePresent {

            UserDefaults.standard.set(true, forKey: Defaults.firstAppLaunch.rawValue)
            UserDefaults.standard.synchronize()

            self.guidePresent = false
            UIView.animate(withDuration: 0.4, animations: {
                fingerImageView.alpha = 0.0
                }, completion: { completed in
                    fingerImageView.removeFromSuperview()
            })
        }
    }
}
