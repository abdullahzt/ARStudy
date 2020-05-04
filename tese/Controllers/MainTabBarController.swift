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
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        button.setDimensions(width: 50, height: 50)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        self.tabBar.barStyle = .black
        self.tabBar.tintColor = UIColor(red: 215/255, green: 56/255, blue: 94/255, alpha: 1)
        
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 15)
        
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
