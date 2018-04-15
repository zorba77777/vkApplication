//
//  UserGroupTableViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 27/01/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit

class UserGroupTableViewController: UITableViewController {

    var destinationViewContoroller: GroupTableViewController!
    var userGroups: [(Int, String, Bool, Int)]!
    var userGroupsImages: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var counter = 0
        
        while counter < destinationViewContoroller.groups.count {
            if destinationViewContoroller.groups[counter].2 == true {
                
                if userGroups?.append(destinationViewContoroller.groups[counter]) == nil {
                    userGroups = [destinationViewContoroller.groups[counter]]
                }
                
                if userGroupsImages?.append(destinationViewContoroller.images[counter]) == nil {
                    userGroupsImages = [destinationViewContoroller.images[counter]]
                }
            }
            counter = counter + 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if userGroups == nil {
            return 0
        } else {
            return self.userGroups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroupName", for: indexPath) as! UserGroupTableViewCell
        let index = indexPath.row
        let image = self.userGroupsImages[index]
        
        cell.imageView?.image = image
        
        cell.textLabel?.text = self.userGroups[index].1 + " (" + String(self.userGroups[index].3) + ")"
        
        return cell
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath)
            let text = cell?.textLabel?.text
            let char = text?.index(of: "(")
            let beginning = text![..<char!]
            let groupName = String(beginning).trimmingCharacters(in: .whitespaces)
            
            self.userGroups.remove(at: indexPath.row)
            self.userGroupsImages.remove(at: indexPath.row)
            
            var counter = 0            
            while counter < destinationViewContoroller.groups.count {
                if destinationViewContoroller.groups[counter].1 == groupName {
                    destinationViewContoroller.groups[counter].2 = false
                }
                counter = counter + 1
            }
            tableView.reloadData()
        }
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
