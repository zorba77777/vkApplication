//
//  vkRequests.swift
//  vkApplication
//
//  Created by Timur Sasin on 09/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import VK_ios_sdk

enum VkRequestEnum: String {
    var userId: String {
        guard let id = VKSdk.accessToken().userId else {
            print("Something went wrong with VKSdk")
            return ""
        }
        return id
    }
    var vkToken: String {        
        guard let token = VKSdk.accessToken().accessToken else {
            print("Something went wrong with VKSdk")
            return ""
        }
        return token
    }
    
    var baseUrl: String {return "https://api.vk.com/method/"}
    var version: String {return "5.68"}
    
    case friends = "friends.get?fields=photo_50,photo_200_orig&order=name"
    case groups = "groups.get?extended=1&fields=members_count&offset=0&count=100"
    case news = "newsfeed.get?filters=post"
    case post = "wall.post?friends_only=1&publish_date=1544572800"
    case friendRequests = "friends.getRequests"
    
    func getUrlString()->String {
        if userId == "" || vkToken == "" {
            print("Something went wrong with VKSdk")
            return ""
        }
        switch self {
        case .friends, .groups, .news, .friendRequests:
            return baseUrl + self.rawValue + "&user_id=" + userId + "&access_token=" + vkToken + "&v=" + version
        case .post:
            return baseUrl + self.rawValue + "&owner_id=" + userId + "&access_token=" + vkToken + "&v=" + version
        }
    }
}
