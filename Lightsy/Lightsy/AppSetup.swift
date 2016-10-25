//
//  AppSetup.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 25.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

class AppSetup {
    
    // SET TO FALSE BEFORE FLIGHT
    var isTesting = false
    var shouldSaveState: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Defaults.shouldStoreProgress.rawValue)
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: Defaults.shouldStoreProgress.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var sharedState: AppSetup {
        struct Static {
            static let instance = AppSetup()
        }
        return Static.instance
    }
}
