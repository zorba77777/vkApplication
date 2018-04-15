//
//  TimeStorage.swift
//  vkApplication
//
//  Created by Timur Sasin on 09/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

class TimeStorage {
    
    static let instance = TimeStorage()
    
    var time: Int
    var justCreated: Bool
    
    private init() {
        self.time = Int(Date().timeIntervalSince1970)
        self.justCreated = true
    }   
    
}
