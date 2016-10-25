//
//  Strings.swift
//  Lightsy
//
//  Created by Fabian Ehlert on 24.10.16.
//  Copyright © 2016 Fabian Ehlert. All rights reserved.
//

import Foundation

enum Defaults: String {
    case
    firstAppLaunch = "letLightsyFirstAppLaunch",
    storedProgress = "letStoredProgress"
}

enum NotificationName: String {
    case
    appWillTerminate = "notificationAppWillTerminate"
}

enum Segue: String {
    case
    showCopyright = "showCopyright"
}
