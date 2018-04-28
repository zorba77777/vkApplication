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
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?
    let backgroundTasksManager = BackgroundTasksManager()
    var session: WCSession?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        backgroundTasksManager.checkNewFriends()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        return true
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Swift.Void) {
        
        guard let news = VkRequestEnum.news.getOnlineNews() else {
            print("Something went wrong with VkRequestEnum.news.getOnlineNews()")
            return
        }

        var counter: Int = 0
        var resultDictionary:[String:String]?
        while (counter < news.count) {
            if resultDictionary == nil {
                resultDictionary = [String(counter):news[counter].authorName + "\n" + news[counter].newsText]
            } else {
                resultDictionary?[String(counter)] = news[counter].authorName + "\n" + news[counter].newsText
            }
            counter += 1
        }

        guard let dictionary = resultDictionary else {
            print("Something went wrong with reply for iWatch preparation")
            return
        }
        
        if message["request"] as? String == "news" {
            replyHandler(dictionary)
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func sessionDidBecomeInactive(_ session: WCSession) {  }
    
    func sessionDidDeactivate(_ session: WCSession) {  }
    
}

