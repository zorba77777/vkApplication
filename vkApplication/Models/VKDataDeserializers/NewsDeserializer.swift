//
//  News.swift
//  vkApplication
//
//  Created by Timur Sasin on 24/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

class NewsDeserializer: Decodable {
    
    struct Response: Decodable {
        var items: Array<Item> = []
        var profiles: Array<Profiles>? = nil
        var groups: Array<Groups>? = nil
    }
    
    struct Item: Decodable {
        var type: String = ""
        var source_id: Int = 0
        var text: String = ""
        var comments: Comments
        var likes: Likes
        var reposts: Reposts
        var views: Views? = nil
        var attachments: Array<Attachments>? = nil
        var copy_history: Array<Copy_history>? = nil
    }
    
    struct Attachments: Decodable {
        var type: String = ""
        var video: Video? = nil
        var photo: Photo? = nil
        var link: Link? = nil
    }
    
    var response: Response
    
    struct Comments: Decodable {
        var count: Int = 0
    }
    
    struct Likes: Decodable {
        var count: Int = 0
    }
    
    struct Reposts: Decodable {
        var count: Int = 0
    }
    
    struct Views: Decodable {
        var count: Int = 0
    }
    
    struct Video: Decodable {
        var title: String = ""
        var description: String = ""
        var photo_130: String = ""
    }
    
    struct Photo: Decodable {
        var text: String = ""
        var photo_130: String = ""
    }
    
    struct Copy_history: Decodable {
        var text: String = ""
        var attachments: Array<Attachments>? = nil
    }
    
    struct Link: Decodable {
        var title: String = ""
        var description: String = ""
        var photo: Photo? = nil
    }
    
    struct Profiles: Decodable {
        var id: Int = 0
        var first_name: String = ""
        var last_name: String = ""
        var photo_50: String = ""
    }
    
    struct Groups: Decodable {
        var id: Int = 0
        var name: String = ""
        var photo_50: String = ""
    }
    
}
