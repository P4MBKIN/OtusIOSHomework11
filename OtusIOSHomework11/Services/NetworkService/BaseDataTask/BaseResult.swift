//
//  BaseRequest.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 12.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

enum BaseResult<Model: Decodable, ErrorModel: Decodable> {
    
    case everything
    
    func requestResult(params: [String: String]?, addHeaders: [String: String]?, completion: @escaping (Model?, ErrorModel?, Error?) -> Void) {
        switch self {
        case .everything:
            BaseDownload.downloadTask(
                request: BaseRequest.everything.returnType(params: params, addHeaders: addHeaders),
                session: BaseSession.main.returnType()) { (data, error) in
                    guard error == nil else { return completion(nil, nil, error!)}
                    guard let data = data else { return completion(nil, nil, BaseResultError.nilDataError)}
                    let (model, error): (Model?, Error?) = self.parseJson(data: data)
                    if model != nil {
                        completion(model, nil, nil)
                        return
                    } else {
                        let (errorModel, _): (ErrorModel?, Error?) = self.parseJson(data: data)
                        if errorModel != nil {
                            completion(nil, errorModel, nil)
                            return
                        } else {
                            completion(nil, nil, error)
                            return
                        }
                    }
            }
        }
    }
    
    private func parseJson<T: Decodable>(data: Data) -> (T?, Error?) {
        var model: T?
        var error: Error?
        do {
            let decoder = JSONDecoder()
            model = try decoder.decode(T.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            error = DecodingError.dataCorrupted(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            error = DecodingError.keyNotFound(key,context)
        } catch DecodingError.typeMismatch(let type, let context) {
            error = DecodingError.typeMismatch(type,context)
        } catch DecodingError.valueNotFound(let value, let context) {
            error = DecodingError.valueNotFound(value,context)
        } catch let jsonError{
            error = jsonError
        }
        return (model, error)
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
