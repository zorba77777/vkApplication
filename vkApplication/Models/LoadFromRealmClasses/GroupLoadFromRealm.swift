//
//  GroupLoadFromRealm.swift
//  vkApplication
//
//  Created by Timur Sasin on 10/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class GroupLoadFromRealm: AbstractRealmLoader {
   
    let realmConfig = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    var objects: Array<StructToFillTable>!
    
    func load() {
        do {
            let realm = try Realm(configuration: realmConfig)
            let communities = realm.objects(GroupDBDataModel.self)
            
            for community in communities {
                let community = Community(id: String(community.id), name: community.name)
                
                if objects == nil {
                    objects = [community]
                } else {
                    objects?.append(community)
                }                
            }
        } catch {
            print(error)
        }
    }
    
    
}
