//
//  LoadFromRealmClass.swift
//  vkApplication
//
//  Created by Timur Sasin on 10/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

protocol AbstractRealmLoader {
    var objects: Array<StructToFillTable>! {get set}
    func load()
}
