//
//  News.swift
//  vkApplication
//
//  Created by Timur Sasin on 09/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

struct News: StructToFillTable {
    var id: String
    var name: String = ""
    let authorName: String
    let likesCount: String
    let repostsCount: String
    let viewsCount: String
    let newsText: String
}
