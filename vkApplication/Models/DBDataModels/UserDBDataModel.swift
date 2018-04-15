//
//  UserRealm.swift
//  vkApplication
//
//  Created by Timur Sasin on 04/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//
import Foundation
import RealmSwift

class UserDBDataModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var photo_50 = ""
    @objc dynamic var photo_200_orig = ""
    @objc dynamic var online = 0
        
    override static func primaryKey() -> String? {
        return "id"
    }
}
