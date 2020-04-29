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
    
    private let notesTextView = CaptionTextView()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        self.title = "Notes"
        
        view.addSubview(notesTextView)
        notesTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor,
                             right: view.rightAnchor,
                             paddingTop: 12,
                             paddingLeft: 12,
                             paddingBottom: 12,
                             paddingRight: 12)
    }
    
    func configureNavigationBar() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 215/255, green: 56/255, blue: 94/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
    }
    
    //MARK: - Handlers
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
