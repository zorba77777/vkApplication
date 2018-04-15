//
//  GroupParsing.swift
//  vkApplication
//
//  Created by Timur Sasin on 10/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class GroupParsingClass: VkContentParsingClass {
    var objects: Array<StructToFillTable>! = nil
    
    var images: [Image]! = nil
    
    var realmObjects: Array<Object>! = nil    
    
    func parseData(data: Data?) {
        guard let data = data,
            let json = try? JSONDecoder().decode(GroupDeserializer.self, from: data) else {
                return
        }
        for value in json.response.items {
            let community = Community(id: String(value.id), name: value.name)
            
            if objects == nil {
                objects = [community]
            } else {
                objects?.append(community)
            }
            
            let groupRealm = GroupDBDataModel()
            groupRealm.id = value.id
            groupRealm.name = value.name
            groupRealm.screen_name = value.screen_name
            groupRealm.is_closed = value.is_closed
            groupRealm.type = value.type
            groupRealm.is_admin = value.is_admin
            groupRealm.is_member = value.is_member
            groupRealm.members_count = value.members_count
            groupRealm.photo_50 = value.photo_50
            groupRealm.photo_100 = value.photo_100
            groupRealm.photo_200 = value.photo_200
            
            if realmObjects == nil {
                realmObjects = [groupRealm]
            } else {
                realmObjects?.append(groupRealm)
            }
            
            let image = Image(id: "", name: String(value.id), url: value.photo_50)
            
            if images == nil {
                images = [image]
            } else {
                images?.append(image)
            }
        }
    }
}
