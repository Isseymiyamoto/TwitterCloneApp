//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/04/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable{
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
    
}

struct ProfileHeaderViewModel {

    private let user: User
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 0, text: " following")
    }
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: 2, text: " followers")
    }
    
    var actionButtonTitle: String {
        // if user is current user then set to edit profile
        if user.isCurrentUser {
            return "Edit Profile"
        }else{
            return "Follow"
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: "\(text)",
                                                  attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                               NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
}
