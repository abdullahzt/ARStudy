//
//  LoginController.swift
//  ARStudy
//
//  Created by Abdullah on 12/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let font = UIFont(name: "BetmRounded-SemiBold", size: 40)
        label.font = font
        label.text = "ARStudy"
        label.textColor = APP_RED
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let font = UIFont(name: "BetmRounded-SemiBold", size: 20)
        label.font = font
        label.text = "Manage your notes in a more modern way. Login to sync, save and access your notes from the web"
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = Utilities.textField(withPlaceholder: "Email ID")
        return textField
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(textField: emailTextField)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let textField = Utilities.textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.inputContainerView(textField: passwordTextField)
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = Utilities.mainButton(withText: "Login")
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities.attributedButton("Dont Have an Account?", "Sign Up")
        button.addTarget(self, action: #selector(handleSignUpController), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem?.tintColor = APP_RED
        
        let descriptionStack = UIStackView(arrangedSubviews: [logoLabel, descriptionLabel])
        descriptionStack.axis = .vertical
        descriptionStack.spacing = 15
        
        view.addSubview(descriptionStack)
        descriptionStack.centerX(inView: self.view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        descriptionStack.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 15, paddingRight: 15)
        
        let inputStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        inputStack.axis = .vertical
        inputStack.spacing = 20
        
        view.addSubview(inputStack)
        inputStack.centerX(inView: self.view, topAnchor: descriptionStack.bottomAnchor, paddingTop: 20)
        inputStack.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: self.view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 15)
    }
    
    //MARK: - Handlers
    
    @objc func loginButtonTapped() {
        
    }
    
    @objc func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSignUpController() {
        
    }
}

    //MARK: - UITextFieldDelegate
extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
