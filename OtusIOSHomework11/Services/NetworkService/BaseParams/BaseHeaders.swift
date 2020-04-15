//
//  BaseRequestHeader.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 14.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

enum BaseHeaders {
    
    case everything
    
    func returnType() -> [String: String]? {
        var headers: [String: String]?
        switch self {
        case .everything:
            headers = nil
        }
        return headers
    }
}
