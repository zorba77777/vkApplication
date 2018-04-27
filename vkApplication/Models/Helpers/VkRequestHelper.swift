//
//  vkDownloadHelper.swift
//  vkApplication
//
//  Created by Timur Sasin on 09/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import VK_ios_sdk
import RealmSwift

class VkRequestHelper {
    
    let realmConfig = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    var parser: VkContentParsingClass!
    let downloadType: VkRequestEnum
    var time: Int = Int(Date().timeIntervalSince1970)
    
    init(downloadType: VkRequestEnum) {
        
        self.downloadType = downloadType
        
        switch downloadType {
        case .friends:
            self.parser = FriendParsingClass()
        case .groups:
            self.parser = GroupParsingClass()
        case .news:
            self.parser = NewsParsingClass()
        default:
            self.parser = nil
        }        
    }
    
    func downloadDataFromVk(controller: VkTableViewController) {
        
        var controller = controller
        
        let urlString = downloadType.getUrlString()        
        if urlString == "" {
            print("Something went wrong with VKSdk")
        }
                
        guard let url = URL(string: urlString) else {
            print("Something went wrong with vkRequest url")
            return
        }
        URLSession.shared.dataTask(with: url) {
            [unowned self]
            (data, response, error)
            in
            self.parser.parseData(data: data)
            self.saveObjectsInRealm()
            self.saveImagesInDocumentDirectory()
            controller.objects = self.parser.objects
            self.parser.objects = nil
            DispatchQueue.main.async {
                controller.tableView.reloadData()
            }
            }.resume()
    }
    
    func sendRequestToVk(message: String)->Bool {
        var request = downloadType.getUrlString() + "&message="
        guard let messageProcessed = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Something went wrong with encoding post message")
            return false
        }
        request = request + messageProcessed
        let url = URL(string: request)
        guard let data = try? Data(contentsOf: url!), let response = try? JSONDecoder().decode(PostResponseDeserializer.self, from: data) else {
            print("Something went wrong with post response")
            return false
        }
        if response.error != nil {
            print(response.error.error_msg)
            return false
        } else {
            return true
        }
    }
    
    func saveObjectsInRealm() {
        let timeStorage = TimeStorage.instance
        let lastTime = timeStorage.time
        let currentTime = Int(Date().timeIntervalSince1970)
        let timeInterval = currentTime - lastTime
        
        if (self.parser.realmObjects != nil) && ((timeInterval > 300) || (timeStorage.justCreated)) {            
            timeStorage.time = Int(Date().timeIntervalSince1970)
            timeStorage.justCreated = false
            for realmObject in self.parser.realmObjects {
                do {
                    let realm = try Realm(configuration: self.realmConfig)                    
                    realm.beginWrite()
                    realm.add(realmObject, update: true)
                    try realm.commitWrite()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func saveImagesInDocumentDirectory() {
        guard let images = self.parser.images else {
            print("Something went wrong with downloaded images")
            return
        }
        
        for image in images {
            guard let imageData = self.getImageData(urlString: image.url) else {
                print("Something went wrong with getting image data")
                return
            }
            self.saveOneImageInDocumentDirectory(imageName: image.name, data: imageData)
        }
    }
    
    func getImageData(urlString: String)->Data? {
        guard let url = URL(string: urlString) else {
            print("Something went wrong with image url")
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            print("Something went wrong with image data")
            return nil
        }
        return data
    }
    
    func saveOneImageInDocumentDirectory(imageName: String, data: Data){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
    }   
    
}
