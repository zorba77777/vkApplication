//
//  PostResponseDeserializer.swift
//  vkApplication
//
//  Created by Timur Sasin on 08/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

class PostResponseDeserializer: Decodable {
    
    struct Response: Decodable {
        var post_id: Int = 0
    }
    
    struct Error: Decodable {
        var error_msg: String = ""
    }
    
    var response: Response!
    
    var error: Error!
    
}
