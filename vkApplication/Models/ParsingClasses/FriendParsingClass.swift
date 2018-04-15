//
//  FriendParsing.swift
//  vkApplication
//
//  Created by Timur Sasin on 09/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class FriendParsingClass: VkContentParsingClass {
    var objects: Array<StructToFillTable>! = nil
    
    var images: [Image]! = nil
    
    var realmObjects: Array<Object>! = nil    
    
    func parseData(data: Data?) {
        guard let data = data,
            let json = try? JSONDecoder().decode(UserDeserializer.self, from: data) else {
                return
        }
        for value in json.response.items {
            let friend = Friend(id: String(value.id), name: value.first_name + " " + value.last_name)
            
            if objects == nil {
                objects = [friend]
            } else {
                objects?.append(friend)
            }
            
            let userRealm = UserDBDataModel()
            userRealm.id = value.id
            userRealm.first_name = value.first_name
            userRealm.last_name = value.last_name
            userRealm.photo_50 = value.photo_50
            userRealm.photo_200_orig = value.photo_200_orig
            userRealm.online = value.online
            
            if realmObjects == nil {
                realmObjects = [userRealm]
            } else {
                realmObjects?.append(userRealm)
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
