//
//  ArticleError.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

struct NewsError: Decodable {
    
    let status: String?
    let code: String?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String?.self, forKey: .status)
        code = try container.decode(String?.self, forKey: .code)
        message = try container.decode(String?.self, forKey: .message)
    }
}

extension NewsError: CustomStringConvertible {
    
    var description: String {
        return  """
                News Error!!!
                Status: \(status ?? "")
                Code: \(code ?? "")
                Message: \(message ?? "")
                """
    }
}
