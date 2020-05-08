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
    
    var menuController: MenuController!
    var centerController: MainScreenController!
    
    var isExpanded = false
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.7)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK: - Helpers
    
    func configureHomeController() {
        let mainScreenController = MainScreenController(collectionViewLayout: UICollectionViewFlowLayout())
        mainScreenController.delegate = self
        centerController = mainScreenController
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            //first time opening
            menuController = MenuController()
            menuController.delegate = self
            
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            
        }
    }
    
    func animateMenu(shouldExpand: Bool, menuOption: MenuOption?) {
        if shouldExpand {
            //need to show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                
            }, completion: nil)
            
        } else {
            //need to hide menu
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
                
            }
        }
        
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
            
        case .Settings:
            print("Handle Setting")
        case .Help:
            print("Handle Help")
        case .About:
            print("Handle About")
        }
        
    }
    
}

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        } else {
            centerController.removeBlackView()
        }
        
        isExpanded = !isExpanded
        animateMenu(shouldExpand: isExpanded, menuOption: menuOption)
    }
    
}
