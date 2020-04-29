//
//  Constants.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/04/23.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Firebase
import FirebaseStorage

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGE = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")