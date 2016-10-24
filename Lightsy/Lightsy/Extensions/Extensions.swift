//
//  Extensions.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 24.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

extension CGFloat {
    func fitTo(range: ClosedRange<CGFloat>) -> CGFloat {
        if range ~= self { return self }
        return [range.lowerBound, range.upperBound].enumerated().min(by: { abs($0.1 - self) < abs($1.1 - self) })?.element ?? 0.0
    }
}

// Usage: insert view.pushTransition right before changing content
// http://stackoverflow.com/questions/33632266/animate-text-change-of-uilabel
extension UIView {
    func fadeTransition(duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionFade)
    }
}
