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
        iv.layer.cornerRadius = 50
        iv.image = UIImage(named: "profile-2")
        return iv
    }()
    
    private let firstNameTextField: UITextField = {
        return UITextField()
    }()
    
    private lazy var firstNameView: UIView = {
        let view = Utilities.inputWhiteView(withTextField: firstNameTextField, text: "First Name", containsTop: true)
        return view
    }()
    
    private let lastNameTextField: UITextField = {
        return UITextField()
    }()
    
    private lazy var lastNameView: UIView = {
        let view = Utilities.inputWhiteView(withTextField: lastNameTextField, text: "Last Name", containsTop: false)
        return view
    }()
    
    private let emailTextField: UITextField = {
        return UITextField()
    }()
    
    private lazy var emailView: UIView = {
        let view = Utilities.inputWhiteView(withTextField: emailTextField, text: "Email ID", containsTop: false)
        return view
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(APP_RED, for: .normal)
        button.setDimensions(width: 70, height: 40)
        return button
    }()
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemGroupedBackground
        self.title = "Profile"
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        
        configureNavigationBar()
        
        view.addSubview(profileImageView)
        profileImageView.centerX(inView: self.view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 15)
        
        
        let inputStack = UIStackView(arrangedSubviews: [firstNameView, lastNameView, emailView])
        inputStack.axis = .vertical
        
        view.addSubview(inputStack)
        inputStack.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10)
        
        view.addSubview(signOutButton)
        signOutButton.anchor(top: inputStack.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingRight: 15)
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

extension ProfileController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
