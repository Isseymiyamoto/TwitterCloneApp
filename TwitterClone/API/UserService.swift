//
//  UserService.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/04/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void){
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionaty: dictionary)
            completion(user)
         
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void){
        var users = [User]()
        REF_USERS.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionaty: dictionary)
            users.append(user)
            completion(users)
        }
    }
}
