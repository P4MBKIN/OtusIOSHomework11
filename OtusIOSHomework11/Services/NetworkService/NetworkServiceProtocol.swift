//
//  ArticleApi.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func everythingGet<Model: Decodable, ErrorModel: Decodable>(topicName: String,
                                                                dateFrom: Date,
                                                                page: Int?,
                                                                completion: @escaping ((Model?, ErrorModel?, Error?) -> Void))
}
