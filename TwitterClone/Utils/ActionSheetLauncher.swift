//
//  ActionSheetLauncher.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/05/11.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation

class ActionSheetLauncher: NSObject{
    
    // MARK: - Properties
    
    private let user: User
    
    init(user: User){
        self.user = user
        super.init()
    }
    
    // MARK: - Helpers
    
    func show(){
        print("DEBUG: show action sheet for user \(user)")
    }
    
}
