//
//  BaseRequest.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 14.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

enum BaseRequest {
    
    case everything
    
    func returnType(params: [String: String]?, addHeaders: [String: String]?) -> URLRequest {
        switch self {
        case .everything:
            var url = BaseUrl.init(scheme: .http, host: .newsApi, path: .everything)
            
            var headers = [String: String]()
            let baseHeaders = BaseHeaders.everything.returnType()
            baseHeaders?.forEach {
                headers[$0.key] = $0.value
            }
            addHeaders?.forEach {
                headers[$0.key] = $0.value
            }
            
            let baseParams = BaseParams.everything.returnType()
            params?.forEach {
                url.queryParams.updateValue($0.value, forKey: $0.key)
            }
            baseParams?.forEach {
                url.queryParams.updateValue($0.value, forKey: $0.key)
            }
            
            var request = URLRequest(url: url.urlConfigList())
            request.httpMethod = BaseMethod.everything.rawValue
            request.allHTTPHeaderFields = headers
            request.timeoutInterval = 60
            return request
        }
    }
}
