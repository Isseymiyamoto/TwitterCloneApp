//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/05/09.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

enum UploadTweetConfiguration{
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    
    let actionButtonTitle: String
    let placeholderText: String
    var shouldShowReplyLabel: Bool
    var replyText: String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's happning?"
            shouldShowReplyLabel = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet your reply"
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}

