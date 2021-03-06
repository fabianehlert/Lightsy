//
//  AppDelegate.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 22.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name(NotificationName.appWillTerminate.rawValue), object: nil)
    }

}

