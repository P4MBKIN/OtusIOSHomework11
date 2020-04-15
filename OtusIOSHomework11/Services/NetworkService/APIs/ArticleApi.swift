//
//  ArticleApi.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

struct ArticleApi: ArticleApiProtocol {
    
    func everythingGet(topicName: String, dateFrom: Date, completion: @escaping ((ArticleList?, ArticleError?, Error?) -> Void)) {
        var params = [String: String]()
        params["q"] = topicName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        params["from"] = formatter.string(from: dateFrom)
        
        BaseResult.everything.requestResult(params: params, addHeaders: nil, completion: completion)
    }
}
