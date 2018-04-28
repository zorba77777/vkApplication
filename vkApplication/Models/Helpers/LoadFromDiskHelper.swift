//
//  realmHelper.swift
//  vkApplication
//
//  Created by Timur Sasin on 10/02/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import RealmSwift

class LoadFromDiskHelper {
    
    let realmConfig = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    let loader: AbstractRealmLoader!
    
    init(loadType: VkRequestEnum) {
        switch loadType {
        case .friends:
            self.loader = FriendLoadFromRealm()
        case .groups:
            self.loader = GroupLoadFromRealm()
        default:
            self.loader = nil
        }
    }
    
    func getLoadedData()->Array<StructToFillTable>? {
        self.loader.load()
        guard let objects = self.loader.objects else {
            return nil
        }
        return objects
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImage(imageName: String)->UIImage?{
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
        guard let image = UIImage(contentsOfFile: imagePath) else {
            return nil
        }
        return image
    }
}
