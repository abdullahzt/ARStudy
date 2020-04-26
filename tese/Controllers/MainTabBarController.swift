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
        
        let liveVideoController = LiveVideoViewController()
        liveVideoController.tabBarItem.title = "Video"
        liveVideoController.tabBarItem.image = UIImage(systemName: "video.fill")
        
        let notesViewcontroller = NotesViewController()
        notesViewcontroller.tabBarItem.title = "Notes"
        notesViewcontroller.tabBarItem.image = UIImage(systemName: "book.fill")
        
        let modelViewController = ModelViewController()
        modelViewController.tabBarItem.title = "Models"
        modelViewController.tabBarItem.image = UIImage(systemName: "square.stack.3d.up.fill")
        
        viewControllers = [liveVideoController, modelViewController, notesViewcontroller]
    }
    
}
