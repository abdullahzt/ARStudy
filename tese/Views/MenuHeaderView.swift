//
//  MenuHeaderView.swift
//  ARStudy
//
//  Created by Abdullah on 08/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView {
    
    //MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "Guest User"
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = "Guest@ARStudy.com"
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(width: 70, height: 70)
        iv.image = UIImage(named: "profile")?.withTintColor(.white)
        return iv
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = APP_RED
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 30, paddingLeft: 10)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: profileImageView.rightAnchor, paddingTop: 40, paddingLeft: 10)
    }
    
}
