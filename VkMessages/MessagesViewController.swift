//
//  MessagesViewController.swift
//  VkMessages
//
//  Created by Timur Sasin on 15/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    @IBOutlet weak var textMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var sharedProfiles: String
        sharedProfiles = "\n" + self.getSharedProfiles()
        self.textMessage.text = (self.textMessage.text ?? "") + sharedProfiles
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        let layout = MSMessageTemplateLayout()
        layout.caption = "Sharing friends profiles"
        layout.subcaption = self.textMessage.text
        let message = MSMessage()
        message.layout = layout
        activeConversation?.insert(message, completionHandler: nil)
    }
    
    func getSharedProfiles()->String {
        var resultString: String = ""
        guard let userDefaultsiMessage = UserDefaults(suiteName: "group.iMessage") else {
            print("Something went wrong with group.iMessage container")
            return ""
        }
        
        for (key, value) in userDefaultsiMessage.dictionaryRepresentation() {
            if Int(key) != nil {
                guard let value = value as? Bool else {
                    print("Something went wrong with value of userId in userDefaults")
                    return ""
                }
                if value {
                    resultString += "https://vk.com/id" + key + "\n"
                }
            }
        }
        return resultString
    }
    
}
