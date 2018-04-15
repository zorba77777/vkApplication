//
//  User.swift
//  vkApplication
//
//  Created by Timur Sasin on 03/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

class UserDeserializer: Decodable {
    
    struct UserResponse: Decodable {
        var count: Int = 0
        var items: Array<Item> = []
    }
    
    struct Item: Decodable {
        var id: Int = 0
        var first_name: String = ""
        var last_name: String = ""
        var photo_50: String = ""
        var photo_200_orig: String = ""
        var online: Int = 0
    }
    
    var response: UserResponse    
}
