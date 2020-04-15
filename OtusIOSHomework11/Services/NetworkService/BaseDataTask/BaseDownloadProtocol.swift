//
//  BaseDownloadProtocol.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

protocol BaseDownloadProtocol {
    
    static func downloadTask(request: URLRequest, session: URLSession, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
}
