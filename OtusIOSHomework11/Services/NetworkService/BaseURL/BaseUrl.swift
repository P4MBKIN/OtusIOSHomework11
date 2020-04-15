//
//  BaseURL.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 04.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

struct BaseUrl {
    let scheme: BaseUrlScheme
    let host: BaseUrlHost
    let path: BaseUrlPath?
    var queryParams: [String: String] = [:]
    var urlComponents = URLComponents()
    
    mutating func urlConfigList() -> URL {
        urlComponents.scheme = self.scheme.rawValue
        urlComponents.host = self.host.rawValue
        urlComponents.path = self.path?.rawValue ?? ""
        urlComponents.setQueryItems(with: queryParams)
        guard let url = urlComponents.url else { fatalError("Could not create URL from components")}
        return url
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map{ URLQueryItem(name: $0.key, value: $0.value)}
    }
}
