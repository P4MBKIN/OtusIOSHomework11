//
//  BaseDownload.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 12.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

struct BaseDownload: BaseDownloadProtocol {
    
    static func downloadTask(request: URLRequest,
                             session: URLSession,
                             completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else { return completion(nil, DownloadTaskError.requestError(error: error!))}
            guard let data = data else { return completion(nil, DownloadTaskError.nilDataError)}
            guard let res = response as? HTTPURLResponse else { return completion(nil, DownloadTaskError.responseError)}
            guard (200...299).contains(res.statusCode) else { return completion(nil, DownloadTaskError.serverError(status: res.statusCode))}
            guard let mime = res.mimeType else { return completion(nil, DownloadTaskError.getMineError)}
            guard mime == "application/json" else { return completion(nil, DownloadTaskError.wrongMineError(mine: mime))}
            
            do {
                _ = try JSONSerialization.jsonObject(with: data, options: [])
                completion(data, nil)
            } catch {
                completion(nil, DownloadTaskError.jsonError(error: error.localizedDescription))
            }
        }
        task.resume()
    }
}

enum DownloadTaskError: Error {
    
    case requestError(error: Error)
    case nilDataError
    case responseError
    case serverError(status: Int)
    case getMineError
    case wrongMineError(mine: String)
    case jsonError(error: String)
}

extension DownloadTaskError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .requestError(let error): return "Request error: \(error)!!!"
        case .nilDataError: return "Data is nil!!!"
        case .responseError: return "Response error!!!"
        case .serverError(let status): return "Server error: \(status)!!!"
        case .getMineError: return "Could not get MIME type!!!"
        case .wrongMineError(let mine): return "Wrong MIME type: \(mine)!!!"
        case .jsonError(let error): return "JSON error: \(error)!!!"
        }
    }
}
