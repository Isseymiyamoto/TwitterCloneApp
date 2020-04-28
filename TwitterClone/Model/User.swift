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
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionaty: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionaty["fullname"] as? String ?? ""
        self.email = dictionaty["email"] as? String ?? ""
        self.username = dictionaty["username"] as? String ?? ""
    
        if let profileImageUrlString = dictionaty["profileImageUrl"] as? String{
            guard let url = URL(string: profileImageUrlString) else { return}
            self.profileImageUrl = url
        }
    }
}
