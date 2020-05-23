//
//  User.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/04/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import Firebase

struct User {
    var fullname: String
    let email: String
    var username: String
    var profileImageUrl: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStats?
    var bio: String?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionaty: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionaty["fullname"] as? String ?? ""
        self.email = dictionaty["email"] as? String ?? ""
        self.username = dictionaty["username"] as? String ?? ""
        
        if let bio = dictionaty["bio"] as? String{
            self.bio = bio
        }
    
        if let profileImageUrlString = dictionaty["profileImageUrl"] as? String{
            guard let url = URL(string: profileImageUrlString) else { return}
            self.profileImageUrl = url
        }
    }
}


struct UserRelationStats {
    var followers: Int
    var following: Int
}
