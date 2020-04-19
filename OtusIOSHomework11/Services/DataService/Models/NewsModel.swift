//
//  NewsModel.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RealmSwift
import Foundation

class NewsModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var author: String?
    @objc dynamic var title: String?
    @objc dynamic var info: String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var date: Date?
    
    convenience init(author: String?, title: String?, info: String?, imageUrl: String?, date: Date?) {
        self.init()
        self.author = author
        self.title = title
        self.info = info
        self.imageUrl = imageUrl
        self.date = date
    }
    
    override class func primaryKey() -> String? { return "id" }
}
