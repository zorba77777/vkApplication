//
//  NewsTableViewCell.swift
//  vkApplication
//
//  Created by Timur Sasin on 18/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var authorAvatar: UIImageView!
    
    @IBOutlet weak var likesCount: UILabel!
    
    @IBOutlet weak var repostsCount: UILabel!
    
    @IBOutlet weak var viewsCount: UILabel!
    
    @IBOutlet weak var newsText: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!

}
