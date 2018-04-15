//
//  NewsParsingClass.swift
//  News
//
//  Created by Timur Sasin on 11/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import Foundation

class NewsParsingClass {
    var objects: Array<NewsStruct>! = nil   
    
    func parseData(data: Data?) {
        guard let data = data, let json = try? JSONDecoder().decode(NewsDeserializer.self, from: data) else {
            print("wrong news response")
            return
        }
        
        var counter = 0
        
        for item in json.response.items {
            
            var authorName: String = ""
            
            let id = abs(item.source_id)
            
            if let profiles = json.response.profiles {
                for profile in profiles {
                    if id == profile.id {
                        authorName = profile.first_name + " " + profile.last_name
                    }
                }
            }
            if let groups = json.response.groups {
                for group in groups {
                    if id == group.id {
                        authorName = group.name
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
                case "photo":
                    if let text = attachment.photo?.text {
                        newsText += " " + text
                    }
                case "link":
                    if let title = attachment.link?.title {
                        newsText += " " + title
                    }
                    if let description = attachment.link?.description {
                        newsText += " " + description
                    }
                default:
                    print("Unrecognizable attachment in news parsing type")
                }
            }
            
            let news = NewsStruct(
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
            
            counter = counter + 1
        }
    }
}

