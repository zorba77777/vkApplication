//
//  NewsRealm.swift
//  vkApplication
//
//  Created by Timur Sasin on 25/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var authorName = ""
    @objc dynamic var likesCount = ""
    @objc dynamic var repostsCount = ""
    @objc dynamic var viewsCount = ""
    @objc dynamic var newsText = ""
            
    override static func primaryKey() -> String? {
        return "id"
    }
}
