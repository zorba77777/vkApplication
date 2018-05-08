//
//  InterfaceController.swift
//  WatchNews Extension
//
//  Created by Timur Sasin on 16/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var newsView: WKInterfaceLabel!
    
    var session: WCSession?
    var defaults = UserDefaults.standard
    var newsDictionary: [String:String]?
    var newsNumber = 0
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    @IBAction func showNextNews() {
        guard let dictionary = newsDictionary else {
            print("Something went wrong with dictionary")
            return
        }
        
        if self.newsNumber < (dictionary.count - 1) {
            self.newsNumber += 1
        } else {
            self.newsNumber = 0
        }
        self.newsView.setText(dictionary[String(self.newsNumber)])
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
            session.sendMessage(["request":"news"], replyHandler: { (reply) in
                self.newsDictionary = reply as? [String:String]
                self.newsView.setText(reply["0"] as? String)
            }, errorHandler: { (error) in
                self.newsView.setText("Data is unavailable")
            })
        } else {
            self.newsView.setText("Data is unavailable")
        }
    }
    
}
