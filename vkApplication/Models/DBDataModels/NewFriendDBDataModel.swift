//
//  NewFriendRealm.swift
//  vkApplication
//
//  Created by Timur Sasin on 04/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class NewFriendDBDataModel: Object {
    @objc dynamic var user_id = 0   
    
    override static func primaryKey() -> String? {
        return "user_id"
    }
}

