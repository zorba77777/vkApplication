//
//  BackgroundTaskManager.swift
//  vkApplication
//
//  Created by Timur Sasin on 07/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import UserNotifications

class BackgroundTasksManager {
    private var taskCheckSavedFriends: UIBackgroundTaskIdentifier?
    private var taskiCloudSaveGroupId: UIBackgroundTaskIdentifier?
    
    init() {
        UNUserNotificationCenter.current().getNotificationSettings() { (settings) in
            if settings.authorizationStatus == .denied || settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (granted, error) in
                    if error == nil {
                        print("requestAuthorization() error: \(error?.localizedDescription ?? "")")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
            }
        }
    }
    
    func checkNewFriends() {
        taskCheckSavedFriends = UIApplication.shared.beginBackgroundTask(withName: "Task1", expirationHandler: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            weakSelf.stopTask()
            print("Time is over")
        })
        
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else {
                print("wrong self")
                return
            }
            let urlString = VkRequestEnum.friendRequests.getUrlString()
            guard let url = URL(string: urlString) else {
                print("wrong url")
                weakSelf.stopTask()
                return
            }
            guard let data = try? Data(contentsOf: url), let response = try? JSONDecoder().decode(NewFriendsDeserializer.self, from: data) else {
                    print("wrong response")
                    weakSelf.stopTask()
                    return
            }
            
            var newFriendsCounter = 0
            let savedFriends = DataManager.getSavedFriends()
            for item in response.response.items {
                if !savedFriends.contains(where: { $0.id == item.user_id }) {
                    newFriendsCounter += 1
                }
            }
            
            print(" -- New friends: \(newFriendsCounter)")
            
            if newFriendsCounter > 0 {
                DispatchQueue.main.async {
                    UIApplication.shared.applicationIconBadgeNumber = newFriendsCounter
                }
            }
            weakSelf.stopTask()
        }
    }
    
    private func stopTask() {
        if let taskId = self.taskCheckSavedFriends, taskId != UIBackgroundTaskInvalid {
            UIApplication.shared.endBackgroundTask(taskId)
            self.taskCheckSavedFriends = UIBackgroundTaskInvalid
        }
    }
    
}
