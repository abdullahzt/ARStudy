//
//  MainTabBarController.swift
//  ARStudy
//
//  Created by Abdullah on 23/04/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        self.tabBar.barStyle = .black
        self.tabBar.tintColor = UIColor(red: 215/255, green: 56/255, blue: 94/255, alpha: 1)
        
        let lvcontroller = LiveVideoViewController()
        lvcontroller.tabBarItem.title = "Video"
        lvcontroller.tabBarItem.image = UIImage(systemName: "video.fill")
        
        let nvcontroller = NotesViewController()
        nvcontroller.tabBarItem.title = "Notes"
        nvcontroller.tabBarItem.image = UIImage(systemName: "book.fill")
        
        viewControllers = [lvcontroller, nvcontroller]
    }
    
}
