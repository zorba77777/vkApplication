//
//  File.swift
//  vkApplication
//
//  Created by Timur Sasin on 27/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

class UploadUrlDeserializer: Decodable {
    
    struct UploadUrlResponse: Decodable {
        var upload_url: String = ""
        var album_id: Int = 0
        var user_id: Int = 0
    }
    
    var response: UploadUrlResponse
}
