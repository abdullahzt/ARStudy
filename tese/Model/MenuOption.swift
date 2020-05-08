//
//  MenuOption.swift
//  ARStudy
//
//  Created by Abdullah on 08/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible, CaseIterable {
    
    case Settings
    case Help
    case About
    
    var description: String {
        switch self {
        case .Settings:
            return "Settings"
        case .Help:
            return "Help"
        case .About:
            return "About Us"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Settings:
            return UIImage(systemName: "gear") ?? UIImage()
        case .Help:
            return UIImage(systemName: "lightbulb") ?? UIImage()
        case .About:
            return UIImage(systemName: "i.circle") ?? UIImage()
        }
    }
    
}
