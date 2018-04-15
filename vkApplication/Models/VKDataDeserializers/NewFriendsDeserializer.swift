//
//  NewFriendsDecodable.swift
//  vkApplication
//
//  Created by Timur Sasin on 04/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

class NewFriendsDeserializer: Decodable {
    
    struct Response: Decodable {
        var count: Int = 0
        var items: Array<Item> = []
    }
    
    struct Item: Decodable {
        var user_id: Int = 0        
    }
    
    var response: Response
}
