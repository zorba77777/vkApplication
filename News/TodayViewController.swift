//
//  TodayViewController.swift
//  News
//
//  Created by Timur Sasin on 11/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UITableViewController, NCWidgetProviding {
    
    @IBOutlet weak var warning: UILabel!
    
    let parser = NewsParsingClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            guard let defaults = UserDefaults(suiteName: "group.News") else {
                print("Something went wrong with container")
                return
            }
            
            if let id = defaults.string(forKey: "id"), let token = defaults.string(forKey: "token")  {
                var urlString = "https://api.vk.com/method/newsfeed.get?filters=post&&v=5.68&count=20"
                urlString += "&user_id=" + id
                urlString += "&access_token=" + token
                guard let url = URL(string: urlString) else {
                    print("Something went wrong with url")
                    return
                }
                URLSession.shared.dataTask(with: url) {
                    [unowned self]
                    (data, response, error)
                    in
                    self.parser.parseData(data: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    }.resume()
            } else {
                DispatchQueue.main.async {
                    self.warning.text = "You have to launch main vk app first to authorize"
                    self.parser.objects = nil
                    return
                }
            }
        }
        
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize
        }
        else {
            self.preferredContentSize = CGSize(width: maxSize.width, height: maxSize.height)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if parser.objects != nil {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let objects = parser.objects else {
            return 0
        }
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todayViewCell", for: indexPath) as? TodayViewCell
        
        let news = parser.objects[indexPath.row] as NewsStruct
        cell?.authorName.text = news.authorName
        cell?.likesCount.text = news.likesCount
        cell?.repostsCount.text = news.repostsCount
        cell?.viewsCount.text = news.viewsCount
        cell?.newsText.text = news.newsText
        
        guard let newCell = cell else {
            print("Something went wrong with newsCell return")
            return UITableViewCell()
        }
        return newCell
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
}
