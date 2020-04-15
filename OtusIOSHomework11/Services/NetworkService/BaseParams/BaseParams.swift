//
//  BaseParams.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 14.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

enum BaseParams {
    
    case everything
    
    func returnType() -> [String: String]? {
        var params: [String: String]?
        switch self {
        case .everything:
            params = [String: String]()
            params?["sortBy"] = "publishedAt"
            params?["apiKey"] = "428cdc3ea75045248447b7f8c444d298"
        }
        return params
    }
}
