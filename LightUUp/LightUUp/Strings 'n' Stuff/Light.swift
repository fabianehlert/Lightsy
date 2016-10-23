//
//  Light.swift
//  LightUUp
//
//  Created by Fabian Ehlert on 23.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

/// http://planetpixelemporium.com/tutorialpages/light.html
enum Light {
    case
    candle,
    tungsten40W,
    tungsten100W,
    halogen,
    carbonArc,
    highNoonSun,
    directSun,
    overcastSky,
    clearBlueSky
    
    static let all = [""]
}

extension Light {
    var kelvin: Int {
        switch self {
        case .candle:
            return 1900
        case .tungsten40W:
            return 2600
        case .tungsten100W:
            return 2850
        case .halogen:
            return 3200
        case .carbonArc:
            return 5200
        case .highNoonSun:
            return 5400
        case .directSun:
            return 6000
        case .overcastSky:
            return 7000
        case .clearBlueSky:
            return 20000
        }
    }
    
    var color: UIColor {
        switch self {
        case .candle:
            return UIColor(r: 255, g: 147, b: 41)
        case .tungsten40W:
            return UIColor(r: 255, g: 197, b: 143)
        case .tungsten100W:
            return UIColor(r: 255, g: 214, b: 170)
        case .halogen:
            return UIColor(r: 255, g: 241, b: 224)
        case .carbonArc:
            return UIColor(r: 255, g: 250, b: 244)
        case .highNoonSun:
            return UIColor(r: 255, g: 255, b: 251)
        case .directSun:
            return UIColor(r: 255, g: 255, b: 255)
        case .overcastSky:
            return UIColor(r: 201, g: 226, b: 255)
        case .clearBlueSky:
            return UIColor(r: 64, g: 156, b: 255)
        }
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: 1.0)
    }
}
