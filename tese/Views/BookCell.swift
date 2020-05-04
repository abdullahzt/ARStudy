//
//  BookCell.swift
//  ARStudy
//
//  Created by Abdullah on 04/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
