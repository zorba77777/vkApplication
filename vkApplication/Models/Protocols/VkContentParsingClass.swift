//
//  VkContentParsing.swift
//  vkApplication
//
//  Created by Timur Sasin on 09/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

protocol VkContentParsingClass {
    var objects: Array<StructToFillTable>! {get set}
    var images: [Image]! {get set}
    var realmObjects: Array<Object>! {get set}    
    func parseData(data: Data?)
}
