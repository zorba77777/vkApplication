//
//  VkTableViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 10/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import UIKit

protocol VkTableViewController {
    
    var objects:[StructToFillTable]! {get set}
    
    var tableView: UITableView! {get set}
}
