//
//  ContainerController.swift
//  ARStudy
//
//  Created by Abdullah on 06/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    //MARK: - Properties
    
    var menuController: UIViewController!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK: - Helpers
    
    func configureHomeController() {
        let mainScreenController = MainScreenController(collectionViewLayout: UICollectionViewFlowLayout())
        let controller = UINavigationController(rootViewController: mainScreenController)
        
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            //first time opening
            menuController = MenuController()
        }
    }
    
}
