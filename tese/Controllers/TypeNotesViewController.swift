//
//  TypeNotesViewController.swift
//  ARStudy
//
//  Created by Abdullah on 29/04/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class TypeNotesViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        
    }
    
    //MARK: - Handlers
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
