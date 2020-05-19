//
//  EditProfileCell.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/05/19.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class EditProfileCell: UITableViewCell{
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
