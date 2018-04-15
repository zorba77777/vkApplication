//
//  AppDelegate.swift
//  vkApplication
//
//  Created by Timur Sasin on 26/01/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import VK_ios_sdk
import RealmSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let backgroundTasksManager = BackgroundTasksManager()    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        backgroundTasksManager.checkNewFriends()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        return true
    }
}

