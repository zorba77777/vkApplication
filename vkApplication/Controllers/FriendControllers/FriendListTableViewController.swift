//
//  FriendListTableViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 26/01/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class FriendListTableViewController: UITableViewController, VkTableViewController {        
       
    let vkHelper = VkRequestHelper(downloadType: .friends)
    let loadFromDisk = LoadFromDiskHelper(loadType: .friends)
    let userDefaults = UserDefaults.standard
    var objects: [StructToFillTable]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setIdAndTokenForNewsExtension()

        if self.userDefaults.object(forKey: "firstDownloadFriendsData") != nil {
            self.objects = loadFromDisk.getLoadedData()
        } else {
            vkHelper.downloadDataFromVk(controller: self)            
            self.userDefaults.set(true, forKey: "firstDownloadFriendsData")
        }
        
        self.setFriendsIdsForiMessage()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendNameCell")
        
        guard let friend = objects[indexPath.row] as? Friend else {
            print("Something went wrong with Friend object")
            return UITableViewCell()
        }
        
        guard let id = Int(friend.id) else {
            print("Something went wrong with friend.id")
            return UITableViewCell()
        }
        
        guard let userDefaultsiMessage = UserDefaults(suiteName: "group.iMessage") else {
            print("Something went wrong with group.iMessage container")
            return UITableViewCell()
        }
        
        let shared: Bool
        if userDefaultsiMessage.bool(forKey: friend.id) {
            shared = true
        } else {
            shared = false
        }
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(shared, animated: true)
        switchView.tag = id
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell?.accessoryView = switchView
        
        let image = loadFromDisk.getImage(imageName: friend.id)
        
        cell?.textLabel?.text = friend.name
        cell?.imageView?.image = image
        
        guard let newCell = cell else {
            print("Something went wrong with friendCell return")
            return UITableViewCell()
        }
        return newCell
    }    
    
    @IBAction func refreshDataFromVk(_ sender: UIButton) {
        objects = nil        
        vkHelper.downloadDataFromVk(controller: self)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showCollection" {
            guard let cell = sender as? FriendNameTableViewCell else {
                print("Something went wrong with sender of segue of FriendListViewController")
                return
            }
            guard let index = self.tableView.indexPath(for: cell)?.row else {
                print("Something went wrong with indexPath in segue of FriendListViewController")
                return
            }
            guard let friendImageController = segue.destination as? FriendsCollectionViewController else {
                print("Something went wrong with segue.destination in segue of FriendListViewController")
                return
            }
            guard let friend = objects[index] as? Friend else {
                print("Something went wrong with Friend object")
                return
            }
            let image = loadFromDisk.getImage(imageName: friend.id)
            friendImageController.image = image
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        guard let userDefaultsiMessage = UserDefaults(suiteName: "group.iMessage") else {
            print("Something went wrong with group.iMessage container")
            return
        }
        userDefaultsiMessage.set(sender.isOn, forKey: String(sender.tag))
        userDefaultsiMessage.synchronize()
    }
    
    func setIdAndTokenForNewsExtension() {
        guard let userDefaultsNews = UserDefaults(suiteName: "group.News") else {
            print("Something went wrong with group.News container")
            return
        }
        
        let token = VkRequestEnum.friends.vkToken
        let id = VkRequestEnum.friends.userId
        
        userDefaultsNews.set(token, forKey: "token")
        userDefaultsNews.set(id, forKey: "id")
        userDefaultsNews.synchronize()
    }
    
    func setFriendsIdsForiMessage() {
        guard let userDefaultsiMessage = UserDefaults(suiteName: "group.iMessage") else {
            print("Something went wrong with group.iMessage container")
            return
        }
        guard let friends = self.objects else {
            print("Something went wrong with friends in iMessage")
            return
        }
        
        for friend in self.objects {
            if userDefaultsiMessage.object(forKey: friend.id) == nil {
                userDefaultsiMessage.set(false, forKey: friend.id)
            }
        }
        userDefaultsiMessage.synchronize()
    }
}
