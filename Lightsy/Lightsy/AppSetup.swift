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
            print("Getting state saver")
            return false
        }
        set {
            print("Setting state saver")
        }
    }
    
    class var sharedState: AppSetup {
        struct Static {
            static let instance = AppSetup()
        }
        return Static.instance
    }
}
