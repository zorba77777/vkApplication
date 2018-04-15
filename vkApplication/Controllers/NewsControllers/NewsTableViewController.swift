//
//  NewsTableViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 18/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class NewsTableViewController: UITableViewController, VkTableViewController {
    
    let vkHelper = VkRequestHelper(downloadType: .news)
    let userDefaults = UserDefaults.standard
    let loadFromDisk = LoadFromDiskHelper(loadType: .news)
    var objects: [StructToFillTable]!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        vkHelper.downloadDataFromVk(controller: self)
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = objects?.count else {
            return 0
        }
        return count
    }
    
    @IBAction func refreshDataFromVk(_ sender: UIButton) {
        vkHelper.downloadDataFromVk(controller: self)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell
        
        guard let news = objects[indexPath.row] as? News else {
            print("Something went wrong with News object")
            return UITableViewCell()
        }
        
        let authorAvatar = loadFromDisk.getImage(imageName: "authorAvatar" + news.id)
        let newsImage = loadFromDisk.getImage(imageName: "newsImage" + news.id)

        cell?.authorName.text = news.authorName
        cell?.authorAvatar.image = authorAvatar
        cell?.likesCount.text = news.likesCount
        cell?.repostsCount.text = news.repostsCount
        cell?.viewsCount.text = news.viewsCount
        cell?.newsText.text = news.newsText
        cell?.newsImage.image = newsImage
        
        guard let newCell = cell else {
            print("Something went wrong with newsCell return")
            return UITableViewCell()
        }
        return newCell
    }   
}
