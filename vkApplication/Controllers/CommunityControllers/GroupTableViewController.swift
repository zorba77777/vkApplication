//
//  GroupTableViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 27/01/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class GroupTableViewController: UITableViewController, VkTableViewController {
    
    let vkHelper = VkRequestHelper(downloadType: .groups)
    let userDefaults = UserDefaults.standard
    let loadFromDisk = LoadFromDiskHelper(loadType: .groups)
    var objects: [StructToFillTable]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if self.userDefaults.object(forKey: "firstDownloadGroupsData") != nil {
            self.objects = loadFromDisk.getLoadedData()
        } else {
            vkHelper.downloadDataFromVk(controller: self)
            self.userDefaults.set(true, forKey: "firstDownloadGroupsData")
        }
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupNameCell")
        
        guard let community = objects[indexPath.row] as? Community else {
            print("Something went wrong with community object")
            return UITableViewCell()
        }
        
        let image = loadFromDisk.getImage(imageName: community.id)
        
        cell?.textLabel?.text = community.name        
        cell?.imageView?.image = image
        
        guard let newCell = cell else {
            print("Something went wrong with groupCell return")
            return UITableViewCell()
        }
        return newCell
    }    
    
    @IBAction func refreshDataFromVk(_ sender: UIButton) {
        self.objects = nil
        vkHelper.downloadDataFromVk(controller: self)
        self.tableView.reloadData()
    } 

}
