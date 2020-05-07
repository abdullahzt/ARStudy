//
//  MenuController.swift
//  ARStudy
//
//  Created by Abdullah on 06/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MenuOptionCell"

class MenuController: UIViewController {
    
    //MARK: - Properties
    
    var tableView: UITableView!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        let font = UIFont(name: "BetmRounded-SemiBold", size: 30)
        label.font = font
        label.text = "ARStudy"
        label.textColor = APP_RED
        return label
    }()
    
    private lazy var crossButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cross"), for: .normal)
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(crossButtonTapped), for: .touchUpInside)
        button.tintColor = APP_RED
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newFrame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width - 80, height: self.view.frame.height)

        self.view.frame = newFrame
        
        configureUI()
        
        //only set rounded corner for right side
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        view.backgroundColor = .white
    }
    
    //MARK: - Helpers
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func configureUI() {
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        view.addSubview(crossButton)
        crossButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 22, paddingLeft: 20)
        
    }
    
    //MARK: - Handlers
    
    @objc func crossButtonTapped() {
        
    }
    
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MenuOptionCell
        return cell
    }
    
}
