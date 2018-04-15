//
//  GroupRealm.swift
//  vkApplication
//
//  Created by Timur Sasin on 04/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//
import Foundation
import RealmSwift

class GroupDBDataModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var screen_name = ""
    @objc dynamic var is_closed = 0
    @objc dynamic var type = ""
    @objc dynamic var is_admin = 0
    @objc dynamic var is_member = 0
    @objc dynamic var members_count = 0
    @objc dynamic var photo_50 = ""
    @objc dynamic var photo_100 = ""
    @objc dynamic var photo_200 = ""
        
    override static func primaryKey() -> String? {
        return "id"
    }
}

