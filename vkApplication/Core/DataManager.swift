//
//  DataManager.swift
//  vkApplication
//
//  Created by Timur Sasin on 08/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    static func getSavedFriends() -> [UserDBDataModel] {
        do {
            let realm = try Realm()
            let friends = realm.objects(UserDBDataModel.self)
            return Array(friends)
        } catch {
            print("getSavedFriends() error: \(error.localizedDescription)")
        }
        return [UserDBDataModel]()
    }
    
    static func getSavedGroups() -> [GroupDBDataModel] {
        do {
            let realm = try Realm()
            let groups = realm.objects(GroupDBDataModel.self)
            return Array(groups)
        } catch {
            print("getSavedFriends() error: \(error.localizedDescription)")
        }
        return [GroupDBDataModel]()
    }
    
    static func getOnlineNews() -> [News]? {
        let parser = NewsParsingClass()
        
        guard let defaults = UserDefaults(suiteName: "group.News") else {
            print("Something went wrong with container")
            return nil
        }
        
        if let id = defaults.string(forKey: "id"), let token = defaults.string(forKey: "token")  {
            var urlString = "https://api.vk.com/method/newsfeed.get?filters=post&&v=5.68&count=20"
            urlString += "&user_id=" + id
            urlString += "&access_token=" + token
            guard let url = URL(string: urlString) else {
                print("Something went wrong with url")
                return nil
            }
            guard let data = try? Data(contentsOf: url) else {
                print("Something went wrong with url response")
                return nil
            }
            parser.parseData(data: data)
            guard let news = parser.objects as? [News] else {
                print("Something went wrong with parsing news")
                return nil
            }
            return news
        } else {
            return nil
        }
    }
}
