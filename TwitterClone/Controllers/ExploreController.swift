//
//  ExploreController.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/04/14.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class ExploreController: UIViewController{
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}
