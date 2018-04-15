//
//  NewsParsing.swift
//  vkApplication
//
//  Created by Timur Sasin on 10/03/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation
import RealmSwift

class NewsParsingClass: VkContentParsingClass {
    var objects: Array<StructToFillTable>! = nil
    
    var images: [Image]! = nil
    
    var realmObjects: Array<Object>! = nil    
    
    func parseData(data: Data?) {
        guard let data = data, let json = try? JSONDecoder().decode(NewsDeserializer.self, from: data) else {
                print("wrong news response")
                return
        }
       
        var counter = 0
        
        for item in json.response.items {
            
            var authorName: String = ""
            var authorImageUrl: String = ""
            
            let id = abs(item.source_id)
            
            if let profiles = json.response.profiles {
                for profile in profiles {
                    if id == profile.id {
                        authorName = profile.first_name + " " + profile.last_name
                        authorImageUrl = profile.photo_50
                    }
                }
            }
            if let groups = json.response.groups {
                for group in groups {
                    if id == group.id {
                        authorName = group.name
                        authorImageUrl = group.photo_50
                    }
                }
            }
            
            let likesCount = String(item.likes.count)
            
            let repostsCount = String(item.reposts.count)
            
            let viewsCount: String
            if let views = item.views {
                viewsCount = String(views.count)
            } else {
                viewsCount = "0"
            }
            
            var newsText: String = item.text
            var newsImageUrl: String = ""
           
            var attachments: NewsDeserializer.Attachments? = nil
            if let copyHistory = item.copy_history {
                for value in copyHistory {
                    newsText = " " + newsText + " " + value.text
                    if value.attachments != nil {
                        attachments = value.attachments?[0]
                    }
                }
            } else if let itemAttachments = item.attachments {
                attachments = itemAttachments[0]
            }
            
            if let attachment = attachments {
                switch attachment.type {
                case "video":
                    if let title = attachment.video?.title {
                        newsText += " " + title
                    }
                    if let description = attachment.video?.description {
                        newsText += " " + description
                    }
                    if let photo130 = attachment.video?.photo_130 {
                        newsImageUrl = photo130
                    }
                case "photo":
                    if let text = attachment.photo?.text {
                        newsText += " " + text
                    }
                    if let photo130 = attachment.photo?.photo_130 {
                        newsImageUrl = photo130
                    }
                case "link":
                    if let title = attachment.link?.title {
                        newsText += " " + title
                    }
                    if let description = attachment.link?.description {
                        newsText += " " + description
                    }
                    if let photo130 = attachment.link?.photo?.photo_130 {
                        newsImageUrl = photo130
                    }
                default:
                    print("Unrecognizable attachment in news parsing type")
                }
            }           
            
            let news = News(
                id: String(counter),
                name: "",
                authorName: authorName,
                likesCount: likesCount,
                repostsCount: repostsCount,
                viewsCount: viewsCount,
                newsText: newsText.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            
            if objects == nil {
                objects = [news]
            } else {
                objects?.append(news)
            }            
            
            let authorImage = Image(id: "", name: "authorAvatar" + String(counter), url: authorImageUrl)
            
            if images == nil {
                images = [authorImage]
            } else {
                images?.append(authorImage)
            }
            
            let newsImage = Image(id: "", name: "newsImage" + String(counter), url: newsImageUrl)
            images?.append(newsImage)
            
            counter = counter + 1
        }
    }
}
