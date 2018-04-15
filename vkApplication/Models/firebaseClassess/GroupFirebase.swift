//
//  GroupFirebase.swift
//  vkApplication
//
//  Created by Timur Sasin on 12/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

struct GroupFirebase: Codable {
    let name: String
    
    var toAnyObject: Any {
        return [
            "name": name
        ]
    }
}

