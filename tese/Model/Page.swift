//
//  Page.swift
//  ARStudy
//
//  Created by Abdullah on 03/05/2020.
//  Copyright © 2020 Abdullah. All rights reserved.
//

import Foundation
import RealmSwift

class Page: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var note: String = ""
    var parentBook = LinkingObjects(fromType: Book.self, property: "pages")
}
