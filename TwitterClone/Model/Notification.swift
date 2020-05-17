//
//  Notification.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/05/14.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation

enum NotificationType: Int{
    case follow
    case like
    case reply
    case retweet
    case mention
}

struct Notification {
    let tweetID: String?
    var timestamp: Date!
    let user: User
    var tweet: Tweet?
    var type: NotificationType!
    
    init(user: User, dictionary: [String: AnyObject]) {
        self.user = user
        
        self.tweetID = dictionary["tweetID"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double{
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dictionary["type"] as? Int{
            self.type = NotificationType(rawValue: type)
        }
    }
    
}
