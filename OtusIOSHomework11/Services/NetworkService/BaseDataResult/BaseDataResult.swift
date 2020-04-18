//
//  BaseDataResult.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 16.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

enum BaseDataResult {
    
    case everything
    
    func requestDataResult(params: [String: String]?, addHeaders: [String: String]?, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        switch self {
        case .everything:
            BaseDownload.downloadTask(
                request: BaseRequest.everything.returnType(params: params, addHeaders: addHeaders),
                session: BaseSession.main.returnType()) { (data, error) in
                    completion(data, error)
            }
        }
    }
}
