//
//  ArticleApi.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func everythingGet<Model: Decodable, ErrorModel: Decodable>(topicName: String,
                                                                dateFrom: Date,
                                                                page: Int?,
                                                                completion: @escaping ((Model?, ErrorModel?, Error?) -> Void)) {
        var params = [String: String]()
        params["q"] = topicName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        params["from"] = formatter.string(from: dateFrom)
        
        if let page = page { params["page"] = String(page) }
        
        BaseDataResult.everything.requestDataResult(params: params, addHeaders: nil) { (data, error) in
            guard let data = data else { return completion(nil, nil, BaseResultError.nilDataError) }
            guard error == nil else {
                let (errorModel, _): (ErrorModel?, Error?) = parseJson(data: data)
                return completion(nil, errorModel, error)
            }
            let (model, parseError): (Model?, Error?) = parseJson(data: data)
            if model != nil { return completion(model, nil, nil) }
            else { return completion(nil, nil, parseError) }
        }
    }
}

enum BaseResultError: Error {
    case nilDataError
}

extension BaseResultError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .nilDataError: return "Data is nil!!!"
        }
    }
}
