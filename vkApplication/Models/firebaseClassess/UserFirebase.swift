//
//  userFirebase.swift
//  vkApplication
//
//  Created by Timur Sasin on 12/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

struct UserFirebase: Codable {
    let id: String
    var groups: [GroupFirebase]
    
    var toAnyObject: Any {
        return [
            "id": id,
            "groups": groups.map{ $0.toAnyObject }        
        ]
    }
}
