//
//  FriendLoadFromRealm.swift
//  vkApplication
//
//  Created by Timur Sasin on 10/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class FriendLoadFromRealm: AbstractRealmLoader {
    
    let realmConfig = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    var objects: Array<StructToFillTable>!
    
    func load() {
        do {
            let realm = try Realm(configuration: realmConfig)
            let friends = realm.objects(UserDBDataModel.self)
            
            for friend in friends {
                
                let friend = Friend(id: String(friend.id), name: friend.first_name + " " + friend.last_name)
               
                if objects == nil {
                    objects = [friend]
                } else {
                    objects?.append(friend)
                }
            }
        } catch {
            print(error)
        }
    }
}
