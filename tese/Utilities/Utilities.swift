//
//  Utitlities.swift
//  ARStudy
//
//  Created by Abdullah on 09/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class Utilities {
    
    static func inputWhiteView(withTextField textField: UITextField, text: String, containsTop: Bool) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = text
        label.textColor = .lightGray
        label.setDimensions(width: 90, height: 25)
        
        view.addSubview(label)
        label.centerY(inView: view, leftAnchor: view.leftAnchor, paddingLeft: 20)
        
        view.addSubview(textField)
        textField.centerY(inView: view, leftAnchor: label.rightAnchor, paddingLeft: 20)
        textField.anchor(right: view.rightAnchor, paddingRight: 10)
        
        let topDividerView = UIView()
        let bottomDividerView = UIView()
        topDividerView.backgroundColor = .darkGray
        bottomDividerView.backgroundColor = .darkGray
        
        view.addSubview(bottomDividerView)
        bottomDividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 12, height: 0.6)
        
        if containsTop {
            view.addSubview(topDividerView)
            topDividerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 12, height: 0.6)
        }
        
        return view
    }
    
}
