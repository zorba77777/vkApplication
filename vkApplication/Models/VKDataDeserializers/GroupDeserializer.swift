//
//  Group.swift
//  vkApplication
//
//  Created by Timur Sasin on 03/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

class GroupDeserializer: Decodable {
    
    struct GroupResponse: Decodable {
        var count: Int = 0
        var items: Array<Item> = []
    }
    
    struct Item: Decodable {
        var id: Int = 0
        var name: String = ""
        var screen_name: String = ""
        var is_closed: Int = 0
        var type: String = ""
        var is_admin: Int = 0
        var is_member: Int = 0
        var members_count: Int = 0
        var photo_50: String = ""
        var photo_100: String = ""
        var photo_200: String = ""
    }
    
    var response: GroupResponse
}
