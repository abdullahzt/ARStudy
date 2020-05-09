//
//  ProfileController.swift
//  ARStudy
//
//  Created by Abdullah on 09/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = APP_RED
        button.setTitle("Save", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32/2
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(width: 100, height: 100)
        iv.image = UIImage(named: "profile")
        return iv
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        self.title = "Profile"
        
        configureNavigationBar()
        
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: self.view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 15)
        
    }
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem?.tintColor = APP_RED
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    //MARK: - Handlers
    
    @objc func cancelTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        self.dismiss(animated: true) {
            //saving code here
        }
    }
}
