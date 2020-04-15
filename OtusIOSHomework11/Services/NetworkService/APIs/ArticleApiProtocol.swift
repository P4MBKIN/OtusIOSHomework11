//
//  ArticleApi.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

protocol ArticleApiProtocol {
    
    func everythingGet(topicName: String, dateFrom: Date, completion: @escaping ((ArticleList?, ArticleError?, Error?) -> Void))
}
