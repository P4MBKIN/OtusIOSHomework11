//
//  Extensions.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RealmSwift
import Foundation

extension Results {
    
    func toArray() -> [Element] {
        return self.compactMap { $0 }
    }
}
