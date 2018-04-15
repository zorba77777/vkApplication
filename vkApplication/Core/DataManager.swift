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
}
