//
//  Helpers.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

enum DataError: Error {
    case initializationRealmError
}

extension DataError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .initializationRealmError: return "DataError - Can't initialize Realm!!!"
        }
    }
}
